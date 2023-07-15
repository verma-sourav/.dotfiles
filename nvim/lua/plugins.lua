local fn = vim.fn

local install_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
local repository = "https://github.com/folke/lazy.nvim.git"

local function installed()
   return vim.loop.fs_stat(install_path)
end

local function install()
   fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      repository,
      install_path,
   })
end

if not installed() then
   install()
end

local options = {
   change_detection = { notify = false },
   performance = {
      rtp = {
         disabled_plugins = {
            "netrwPlugin",
         },
      },
   },
}

vim.opt.runtimepath:prepend(install_path)
require("lazy").setup("config.plugins", options)
