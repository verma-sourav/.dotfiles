local M = {}
local utils = require("core.utils")

-- These will be created as their own user commands
local top_level_commands = {
    {
        name = "GoTest",
        nargs = "?",
        cmd = function(opts)
            require("core.custom.go").test({ verbose = opts.args == "verbose" })
        end,
    },
    {
        name = "GoTestAll",
        nargs = "?",
        cmd = function(opts)
            require("core.custom.go").test_all({ verbose = opts.args == "verbose" })
        end,
    },
    {
        name = "GoTestFile",
        nargs = "?",
        cmd = function(opts)
            require("core.custom.go").test_file({ verbose = opts.args == "verbose" })
        end,
    },
    {
        name = "GoTestFunc",
        nargs = "?",
        cmd = function(opts)
            require("core.custom.go").test_func({ verbose = opts.args == "verbose" })
        end,
    },
}

-- These will be treated as subcommands under the :C user command. This is to make it easier to
-- autocomplete and search for the different commands since their names can be quite different
-- from one another. Another option would be to prefix them all with the same value like some
-- plugins do, but that's just more characters to type since the prefix would likely need to be
-- more than one or two characters.
local custom_subcommands = {
    SaveWithoutFormatting = {
        desc = "Save the file without autocommands to prevent automatic formatting",
        cmd = function()
            -- Saving without autocommands should prevent any formatting
            vim.api.nvim_exec2("noautocmd write", {})
            -- If this is being used, the formatter is usually making extra changes to to the file,
            -- so let's just try to prevent any formatting on future saves of this file too. The
            -- format on save autocommand should avoid formatting a buffer with this set
            vim.b.formatting_disabled = true
        end,
    },
    ToggleLeadingWhitespace = {
        desc = "Toggle the display of leading whitespace",
        cmd = function()
            M.toggle_whitespace("tab:→ ,lead:·")
        end,
    },
    ToggleWhitespace = {
        desc = "Toggle displaying all normal whitespace (tabs, spaces, newline)",
        cmd = function()
            M.toggle_whitespace("tab:→ ,space:·,eol:↩")
        end,
    },
    TrimWhitespace = {
        desc = "Trim trailing whitespace in the current file",
        cmd = function()
            require("mini.trailspace").trim()
        end,
    },
    TrimNewlines = {
        desc = "Trim trailing newlines in the current file",
        cmd = function()
            require("mini.trailspace").trim_last_lines()
        end,
    },
    FindFilesInDir = {
        desc = "Search for files with the current directory as the working directory",
        cmd = function()
            Snacks.picker.files({ dirs = { vim.fn.expand("%:h") } })
        end,
    },
    GrepInDir = {
        desc = "Grep with the current directory as the working directory",
        cmd = function()
            Snacks.picker.grep({ dirs = { vim.fn.expand("%:h") } })
        end,
    },
    GrepByFiletype = {
        desc = "Grep inside files of a specific filetype",
        cmd = function()
            -- This ends up running vim.ui.select to allow the user to select a filetype. When
            -- vim.schedule isn't used, that picker will open in normal mode instead of insert.
            vim.schedule(require("core.custom.pickers").grep_filetype)
        end,
    },
    IndentSpaces = {
        desc = "Change the indentation of the current buffer to use spaces",
        cmd = function()
            vim.schedule(function()
                vim.ui.input({ prompt = "Number of spaces to indent with: " }, function(input)
                    local num = tonumber(input)
                    if not num then
                        utils.error("The provided value was not a valid number")
                        return
                    end
                    utils.use_spaces_local(num)
                end)
            end)
        end,
    },
    IndentTabs = {
        desc = "Change the indentation of the current buffer to use tabs",
        cmd = function()
            utils.use_tabs_local()
        end,
    },
    ResetMarks = {
        desc = "Reset all marks",
        cmd = [[delmarks a-zA-Z0-9]],
    },
}

function M.handle_custom_command(opts)
    local requested = opts.fargs[1]
    local command = custom_subcommands[requested]
    if not command then
        vim.notify(string.format("Unknown subcommand '%s'", requested), vim.log.levels.ERROR)
        return
    end
    if not command.cmd then
        vim.notify(string.format("Subcommand '%s' has no cmd", requested), vim.log.levels.ERROR)
        return
    end
    if type(command.cmd) == "function" then
        command.cmd(opts)
    elseif type(command.cmd) == "string" then
        vim.api.nvim_exec2(command.cmd, {})
    else
        vim.notify(
            string.format("Subcommand '%s' has an unsupported cmd type: %s", requested, type(command.cmd)),
            vim.log.levels.ERROR
        )
        return
    end
end

function M.register_user_commands()
    vim.api.nvim_create_user_command("C", M.handle_custom_command, {
        nargs = 1,
        complete = function(arglead)
            local matches = {}
            for k, _ in pairs(custom_subcommands) do
                if vim.startswith(k, arglead) then
                    table.insert(matches, k)
                end
            end
            return matches
        end,
    })

    for _, c in ipairs(top_level_commands) do
        vim.api.nvim_create_user_command(c.name, c.cmd, { desc = c.desc, nargs = c.nargs or 0 })
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

return M
