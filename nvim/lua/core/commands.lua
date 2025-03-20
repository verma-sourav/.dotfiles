local M = {}

-- This command list is used to populate a picker that I can use to run the commands. These are
-- commands that I find useful, but that I don't necessarily need a dedicated keybind for yet.
M.command_list = {
   {
      name = "Toggle display of all whitespace",
      exec = "ToggleWhitespace",
   },
   {
      name = "Toggle display of leading whitespace",
      exec = "ToggleLeadingWhitespace",
   },
   {
      name = "Save without formatting",
      exec = "SaveWithoutFormatting",
   },
   {
      name = "Disable format-on-save in this buffer",
      exec = function()
         -- The format on save autocommand should avoid formatting a buffer with this set
         vim.b.formatting_disabled = true
      end,
   },
   {
      name = "Find files in the current directory",
      exec = function() Snacks.picker.files({ dirs = { vim.fn.expand("%:h") } }) end,
   },
   {
      name = "Grep in the current directory",
      exec = function() Snacks.picker.grep({ dirs = { vim.fn.expand("%:h") } }) end,
   },
   {
      name = "Grep files by filetype",
      exec = function()
         local status = vim.system({ "rg", "--type-list" }, { text = true }):wait()
         if status.code ~= 0 then
            vim.notify("Failed to execute ripgrep (rg) to grab type list", vim.log.levels.ERROR)
         end

         local line_num = 1
         local filetypes = {}
         for line in status.stdout:gmatch("[^\n]+") do
            local filetype = line:match("^(%w+):")
            if filetype then
               line_num = line_num + 1
               table.insert(filetypes, {
                  idx = line_num,
                  score = line_num,
                  text = line,
                  ft = filetype,
               })
            end
         end

         Snacks.picker({
            items = filetypes,
            layout = { preset = "select" },
            format = function(item)
               local ret = {}
               ret[#ret + 1] = { item.text, "SnacksPickerLabel" }
               return ret
            end,
            confirm = function(picker, item)
               picker:close()
               Snacks.picker.grep({ ft = item.ft })
            end,
         })
      end,
   },
   {
      name = "Indent with spaces",
      exec = function()
         vim.ui.input({ prompt = "Number of spaces to indent with: " }, function(input)
            local num = tonumber(input)
            if not num then vim.notify("The provided value was not a valid number", vim.log.levels.WARN) end
            require("util").use_spaces_local(num)
         end)
      end,
   },
   {
      name = "Indent with tabs",
      exec = function()
         vim.ui.input({ prompt = "Number to use as a tab stop: " }, function(input)
            local num = tonumber(input)
            if not num then vim.notify("The provided value was not a valid number", vim.log.levels.WARN) end
            require("util").use_tabs_local(num)
         end)
      end,
   },
}

-- This is used to cache the picker items once they've been generated. Since the list is static,
-- there's no reason to keep regenerating them.
local command_list_items = {}

-- Runs a Snacks.picker that is loaded with the command list.
function M.command_list_picker()
   if #command_list_items ~= #M.command_list then
      command_list_items = {}
      for i, cmd in ipairs(M.command_list) do
         table.insert(command_list_items, {
            idx = i,
            score = i,
            text = cmd.name,
            exec = cmd.exec,
         })
      end
   end

   Snacks.picker({
      items = command_list_items,
      layout = { preset = "select" },
      format = function(item)
         local ret = {}
         ret[#ret + 1] = { item.text, "SnacksPickerLabel" }
         return ret
      end,
      confirm = function(picker, item)
         picker:close()
         if type(item.exec) == "function" then
            item.exec()
         else
            vim.cmd(item.exec)
         end
      end,
   })
end

function M.register_user_commands()
   local commands = {
      {
         name = "SaveWithoutFormatting",
         desc = "Save the file without autocommands to prevent automatic formatting",
         cmd = "noautocmd write",
      },
      {
         name = "ToggleLeadingWhitespace",
         desc = "Toggle the display of leading whitespace",
         cmd = function() M.toggle_whitespace("tab:→ ,lead:·") end,
      },
      {
         name = "ToggleWhitespace",
         desc = "Toggle displaying all normal whitespace (tabs, spaces, newline)",
         cmd = function() M.toggle_whitespace("tab:→ ,space:·,eol:↩") end,
      },
      {
         name = "TrimTrailingWhitespace",
         desc = "Trim trailing whitespace in the current file",
         cmd = function() require("mini.trailspace").trim() end,
      },
      {
         name = "TrimTrailingNewlines",
         desc = "Trim trailing newlines in the current file",
         cmd = function() require("mini.trailspace").trim_last_lines() end,
      },
   }

   for _, c in ipairs(commands) do
      vim.api.nvim_create_user_command(c.name, c.cmd, { desc = c.desc })
   end

   -- These commands allow you to handle multiple substitutions in a single command call using a
   -- dictionary. Keys in the dictionary will be replaced with their value.
   -- Call example: `:Refactor {'frog':'duck', 'duck':'frog'}`
   -- ref: https://stackoverflow.com/a/766093
   --
   -- This is in vimscript for now because I'm not quite sure how to translate to Lua quite yet :)
   -- stylua: ignore
   vim.api.nvim_exec2([[
      " Refactor is case-sensitive and replaces full words
      function! Refactor(dict) range
         execute a:firstline . ',' . a:lastline .  's/\C\<\%(' . join(keys(a:dict),'\|'). '\)\>/\='.string(a:dict).'[submatch(0)]/ge'
      endfunction

      " MultiSubstitute is case-sensitive, but matches are not required to be full words
      function! MultiSubstitute(dict) range
         execute a:firstline . ',' . a:lastline .  's/\C\%(' . join(keys(a:dict),'\|'). '\)/\='.string(a:dict).'[submatch(0)]/ge'
      endfunction

      command! -range=% -nargs=1 Refactor :<line1>,<line2>call Refactor(<args>)
      command! -range=% -nargs=1 MultiSubstitute :<line1>,<line2>call MultiSubstitute(<args>)
   ]], { output = false })
end

function M.toggle_whitespace(listchars)
   local enabled = M.get_option("list")
   local current_listchars = M.get_option("listchars")

   -- List mode is enabled, but with a different set of characters. I'm going to assume that the
   -- user it switching between different whitespace modes and just update the characters instead.
   -- If they want to disable the whitespace display they should be able to run it again, but if
   -- they use the same function they called originally to toggle off this shouldn't happen.
   if enabled and current_listchars ~= listchars then
      vim.opt.listchars = listchars
      return
   end

   vim.opt.listchars = listchars
   vim.opt.list = not enabled
end

function M.get_option(option)
   local info = vim.api.nvim_get_option_info(option)
   local scopes = { buf = "bo", win = "wo", global = "o" }
   local scope = scopes[info.scope]
   local scope_opts = vim[scope]
   local value = scope_opts[option]
   return value
end

return M
