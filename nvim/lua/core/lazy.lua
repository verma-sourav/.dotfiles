local M = {
    install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim",
    repo_url = "https://github.com/folke/lazy.nvim.git",
}

--- Bootstrap ensures that lazy has been cloned to the local machine. If it's already available
--- in the correct path, no changes will be made. If it's missing, the repository will be cloned.
--- @return nil
function M.bootstrap()
    if vim.uv.fs_stat(M.install_path) then
        return
    end

    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", M.repo_url, M.install_path })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

--- Updates the runtimepath to include Lazy, and configures lazy to load plugins from the
--- core/plugins directory. This function will automatically handle bootstrapping lazy.
--- @return nil
function M.setup()
    M.bootstrap()

    vim.opt.rtp:prepend(M.install_path)
    require("lazy").setup("core.plugins", {
        change_detection = { notify = false },
        concurrency = vim.uv.available_parallelism() * 2,
        performance = {
            rtp = {
                reset = false,
                paths = {
                    -- Allow `~/.config/dots/nvim` to be used as a machine-specific runtime path
                    -- Snippets, ftplugins, etc can be added here.
                    vim.fn.expand("~/.config/dots/nvim"),
                },
                disabled_plugins = {
                    "netrwPlugin",
                },
            },
        },
    })
end

return M
