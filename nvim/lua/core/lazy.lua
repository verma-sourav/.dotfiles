-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
   local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
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

vim.opt.rtp:prepend(lazypath)
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
