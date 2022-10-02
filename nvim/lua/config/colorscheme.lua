-- Available themes (if I keep this updated)
-- kanagawa: https://github.com/rebelot/kanagawa.nvim
-- nightfox: https://github.com/EdenEast/nightfox.nvim
-- catppuccin:  https://github.com/catppuccin/nvim
-- everforest: https://github.com/sainnhe/everforest

vim.g.catppuccin_flavour = "mocha"
require("catppuccin").setup()
vim.cmd("colorscheme catppuccin")
require("lualine").setup({})
