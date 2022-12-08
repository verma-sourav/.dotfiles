local M = {
   "catppuccin/nvim",
}

function M.config()
   vim.g.catppuccin_flavour = "mocha"
   require("catppuccin").setup()
   vim.cmd("colorscheme catppuccin")
end

return M
