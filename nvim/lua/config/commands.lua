local M = {}

function M.register_user_commands()
   local commands = {
      {
         name = "SaveWithoutFormatting",
         cmd = "noautocmd write",
         desc = "Save the file without autocommands to prevent automatic formatting",
      },
      {
         name = "ToggleLeadingWhitespace",
         cmd = M.toggle_display_leading_whitespace,
         desc = "Toggle the display of leading whitespace",
      },
      {
         name = "ToggleWhitespace",
         cmd = M.toggle_display_all_whitespace,
         desc = "Toggle displaying all normal whitespace (tabs, spaces, newline)",
      },
      {
         name = "TrimTrailingWhitespace",
         cmd = M.trim_trailing_whitespace,
         desc = "Trim trailing whitespace in the current file",
      },
      {
         name = "TrimTrailingNewlines",
         cmd = M.trim_trailing_newlines,
         desc = "Trim trailing newlines in the current file",
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

function M.toggle_display_leading_whitespace()
   M.toggle_whitespace("tab:→ ,lead:·")
end

function M.toggle_display_all_whitespace()
   M.toggle_whitespace("tab:→ ,space:·,eol:↩")
end

function M.trim_trailing_whitespace()
   require("mini.trailspace").trim()
end

function M.trim_trailing_newlines()
   require("mini.trailspace").trim_last_lines()
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
