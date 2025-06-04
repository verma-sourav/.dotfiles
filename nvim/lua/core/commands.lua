local M = {}
local utils = require("core.utils")

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
            cmd = function()
                M.toggle_whitespace("tab:→ ,lead:·")
            end,
        },
        {
            name = "ToggleWhitespace",
            desc = "Toggle displaying all normal whitespace (tabs, spaces, newline)",
            cmd = function()
                M.toggle_whitespace("tab:→ ,space:·,eol:↩")
            end,
        },
        {
            name = "TrimTrailingWhitespace",
            desc = "Trim trailing whitespace in the current file",
            cmd = function()
                require("mini.trailspace").trim()
            end,
        },
        {
            name = "TrimTrailingNewlines",
            desc = "Trim trailing newlines in the current file",
            cmd = function()
                require("mini.trailspace").trim_last_lines()
            end,
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
        exec = function()
            Snacks.picker.files({ dirs = { vim.fn.expand("%:h") } })
        end,
    },
    {
        name = "Grep in the current directory",
        exec = function()
            Snacks.picker.grep({ dirs = { vim.fn.expand("%:h") } })
        end,
    },
    {
        name = "Grep files by filetype",
        exec = function()
            -- This ends up running vim.ui.select to allow the user to select a filetype. When
            -- vim.schedule isn't used, that picker will open in normal mode instead of insert.
            vim.schedule(M.grep_for_filetype)
        end,
    },
    {
        name = "Indent with spaces",
        exec = function()
            M.prompt_for_number("Number of spaces to indent with: ", function(num)
                utils.use_spaces_local(num)
            end)
        end,
    },
    {
        name = "Indent with tabs",
        exec = function()
            M.prompt_for_number("Number to use as a tab stop: ", function(num)
                utils.use_tabs_local(num)
            end)
        end,
    },
    {
        name = "Reset all marks",
        exec = [[delmarks a-zA-Z0-9]],
    },
}

--- Runs a picker that allows the user to choose from the commands defined in this module's
--- command_list variable.
function M.command_list_picker()
    local command_list_items = {}
    for i, cmd in ipairs(M.command_list) do
        table.insert(command_list_items, {
            idx = i,
            score = i,
            text = cmd.name,
            exec = cmd.exec,
        })
    end

    Snacks.picker({
        items = command_list_items,
        layout = { preset = "select" },
        format = function(item)
            return { { item.text, "SnacksPickerLabel" } }
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

--- Toggles the display of whitespace using the given set of listchars. The value of listchars
--- should be a valid value for the 'listchars' vim option. If whitespace display is already
--- enabled, but is using a different value for listchars, it will stay enabled but switch to the
--- new value.
--- @param listchars string The setting to use for the listchars vim option
--- @return nil
function M.toggle_whitespace(listchars)
    local enabled = utils.get_option("list")
    local current_listchars = utils.get_option("listchars")

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

--- @class RipgrepFiletype
--- @field name string The name of the file type as reported by ripgrep
--- @field detailed string The detailed info for the filetype with the name and possible extensions

--- Returns a list of available file types from the local instance of ripgrep. If ripgrep is not
--- available, or there is an issue running ripgrep, a nil table will be returned.
--- @return RipgrepFiletype[] | nil
function M.get_ripgrep_filetypes()
    local status = vim.system({ "rg", "--type-list" }, { text = true }):wait()
    if status.code ~= 0 then
        utils.error("Failed to execute ripgrep (rg) to grab type list")
        return nil
    end

    --- @class RipgrepFiletype
    local filetypes = {}
    for line in status.stdout:gmatch("[^\n]+") do
        local filetype = line:match("^(%w+):")
        if filetype then
            table.insert(filetypes, {
                name = filetype,
                detailed = line,
            })
        end
    end
    return filetypes
end

--- Prompts the user for a specific ripgrep filetype and then runs the grep picker with that
--- filetype. This allows searching for text in a specific file type such as a shell script.
--- @return nil
function M.grep_for_filetype()
    local rg_filetypes = M.get_ripgrep_filetypes()
    if rg_filetypes == nil or #rg_filetypes == 0 then
        return
    end

    local items = {}
    for i, ft in ipairs(rg_filetypes) do
        table.insert(items, {
            idx = i,
            score = i,
            text = ft.detailed,
            filetype = ft.name,
        })
    end

    Snacks.picker({
        items = items,
        layout = { preset = "select" },
        format = function(item)
            return { { item.text, "SnacksPickerLabel" } }
        end,
        confirm = function(picker, item)
            picker:close()
            Snacks.picker.grep({ ft = item.filetype })
        end,
    })
end

--- Prompts the user to input a number using the given prompt message. When successful, callback
--- will be executed with the number. If the input is not valid, the callback will be skipped.
--- @param prompt string The message to prompt the user with
--- @param callback fun(number): nil
--- @return nil
function M.prompt_for_number(prompt, callback)
    vim.schedule(function()
        vim.ui.input({ prompt = prompt }, function(input)
            local num = tonumber(input)
            if not num then
                utils.error("The provided value was not a valid number")
                return
            end
            callback(num)
        end)
    end)
end

return M
