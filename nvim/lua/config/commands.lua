local utils = require("utils")

--- Toggles the display of whitespace using the given set of listchars. The value of listchars
--- should be a valid value for the 'listchars' vim option. If whitespace display is already
--- enabled, but is using a different value for listchars, it will stay enabled but switch to the
--- new value.
--- @param listchars string The setting to use for the listchars vim option
--- @return nil
local function toggle_whitespace(listchars)
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

--- @class CustomCommand
--- @field desc string -- Description explaining what the command does
--- @field command string|fun(args: vim.api.keyset.create_user_command.command_args) -- Logic to execute when the command is run
--- @field opts? vim.api.keyset.user_command -- Options to pass through to nvim_create_user_command
--- @type table<string, CustomCommand>
local commands = {
    SaveWithoutFormatting = {
        desc = "Save the file without autocommands to prevent automatic formatting",
        command = function()
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
        command = function()
            toggle_whitespace("tab:→ ,lead:·")
        end,
    },
    ToggleWhitespace = {
        desc = "Toggle the display of all normal whitespace (tabs, spaces, newlines)",
        command = function()
            toggle_whitespace("tab:→ ,space:·,eol:↩")
        end,
    },
    TrimWhitespace = {
        desc = "Trim trailing whitespace in the current file",
        command = function()
            require("mini.trailspace").trim()
        end,
    },
    TrimNewlines = {
        desc = "Trim trailing newlines in the current file",
        command = function()
            require("mini.trailspace").trim_last_lines()
        end,
    },
    IndentSpaces = {
        desc = "Change the indentation of the current buffer to use spaces",
        command = function(opts)
            local num = tonumber(opts.fargs[1])
            if not num then
                utils.error("The provided value was not a valid number")
                return
            end
            utils.use_spaces_local(num)
        end,
        opts = { nargs = 1 },
    },
    IndentTabs = {
        desc = "Change the indentation of the current buffer to use tabs",
        command = function()
            utils.use_tabs_local()
        end,
    },
    ResetMarks = {
        desc = "Reset all marks",
        command = [[delmarks a-zA-z0-9]],
    },
    PackState = {
        desc = "Show the current state of vim.pack",
        command = function()
            vim.pack.update(nil, { offline = true })
        end,
    },
    PackUpdate = {
        desc = "Update all vim.pack plugins",
        command = function()
            vim.pack.update()
        end,
    },
    PackReset = {
        desc = "Reset vim.pack to the state in the lockfile",
        command = function()
            vim.pack.update(nil, { target = "lockfile" })
        end,
    },
    PackDelete = {
        desc = "Remove a plugin from vim.pack and the lockfile",
        command = function(opts)
            vim.pack.del(opts.fargs)
        end,
        opts = {
            nargs = "+",
            complete = "packadd",
        },
    },
    PackHealth = {
        desc = "Check the health of vim.pack",
        command = "checkhealth vim.pack",
    },
}

for name, cmd in pairs(commands) do
    cmd.opts = cmd.opts or {}
    cmd.opts.desc = cmd.desc
    vim.api.nvim_create_user_command(name, cmd.command, cmd.opts)
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
