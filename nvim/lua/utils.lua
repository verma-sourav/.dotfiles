local machine_specific_config_dir = vim.fs.normalize("~/.config/dots/nvim")
local M = {
    option_scopes = { buf = "bo", win = "wo", global = "o" },
    machine_config = {
        pre_plugin_file = vim.fs.joinpath(machine_specific_config_dir, "init.lua"),
        post_plugin_file = vim.fs.joinpath(machine_specific_config_dir, "init-post.lua"),
        snippets = vim.fs.joinpath(machine_specific_config_dir, "snippets"),
    },
}

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

--- Creates an autocmd group with a shared prefix, to make it easier to tell which groups are
--- created within this config, and the clear option already enabled.
--- @param name string - The name of the group
--- @return integer - The ID of the group
function M.autocmd_group(name)
    return vim.api.nvim_create_augroup("dotfiles_" .. name, { clear = true })
end

--- Returns the current project directory. If the directory is inside of a Git repository, the repo
--- root will be returned. The returned path will be an absolute path.
--- @return string
function M.project_dir()
    -- The final empty string is only meant to handle the case where both functions return
    -- nil which shouldn't really happen.
    return vim.fs.root(0, ".git") or vim.uv.cwd() or ""
end

return M
