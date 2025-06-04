local M = {
    option_scopes = { buf = "bo", win = "wo", global = "o" },
}

--- Returns true if an executable with the command name can be found. If this returns false,
--- the program may not be installed, may not be marked as executable, or may just not be
--- available in the current PATH.
--- @param name string
--- @return boolean
function M.executable(name)
    return vim.fn.executable(name) == 1
end

--- A helper for recursively merging two Lua tables together. In scenarios where a key is found
--- in both tables, the value from the right table (addl) will be used.
--- @param base table
--- @param addl table
--- @return table
function M.merge_tables(base, addl)
    return vim.tbl_deep_extend("force", {}, base, addl or {})
end

--- Updates the options for the current buffer to use tabs for indentation
--- @param tabstop? number The number of spaces that a tab should be displayed as
--- @return nil
function M.use_tabs_local(tabstop)
    tabstop = tabstop or 4
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = tabstop
    vim.opt_local.shiftwidth = tabstop
end

--- Updates the options for the current buffer to use spaces for indentation
--- @param num_spaces? number The number of spaces used for a single indentation
--- @return nil
function M.use_spaces_local(num_spaces)
    num_spaces = num_spaces or 4
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = num_spaces
    vim.opt_local.shiftwidth = num_spaces
end

--- Get a list of files matching the pattern
--- @param pattern string The glob pattern to match against
--- @return string[] filepaths List of file paths that matched the pattern
function M.glob(pattern)
    return vim.fn.split(vim.fn.glob(pattern), "\n")
end

--- Prints an info level log
--- @param msg string The message to be logged
--- @return nil
function M.info(msg)
    vim.notify(msg, vim.log.levels.INFO)
end

--- Prints an warn level log
--- @param msg string The message to be logged
--- @return nil
function M.warn(msg)
    vim.notify(msg, vim.log.levels.WARN)
end

--- Prints an error level log
--- @param msg string The message to be logged
--- @return nil
function M.error(msg)
    vim.notify(msg, vim.log.levels.ERROR)
end

--- Returns the current value for the given option. If the option has a local or window value,
--- that value will be preferred. Otherwise the global option will be returned.
--- @param option string
--- @return any
function M.get_option(option)
    local info = vim.api.nvim_get_option_info2(option, {})
    local scope = M.option_scopes[info.scope]
    local scope_opts = vim[scope]
    local value = scope_opts[option]
    return value
end

--- Toggles the current value of the given option. The option is expected to be one that is set via
--- a boolean value. If the option has a local or window value, that value will be toggled.
--- Otherwise the global option will be toggled.
--- @param option string The option to toggle. This should be a boolean option.
--- @param silent? boolean Whether to send a notification about the toggled option
--- @return any
function M.toggle(option, silent)
    local info = vim.api.nvim_get_option_info2(option, {})
    local scope = M.option_scopes[info.scope]
    local scope_opts = vim[scope]
    scope_opts[option] = not scope_opts[option]
    if silent ~= true then
        if scope_opts[option] then
            M.info("enabled vim." .. scope .. "." .. option)
        else
            M.warn("disabled vim." .. scope .. "." .. option)
        end
    end
end

return M
