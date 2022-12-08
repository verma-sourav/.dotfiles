local M = {
   "nvim-lualine/lualine.nvim",
   dependencies = {
      "kyazdani42/nvim-web-devicons",
   },
}

function M.config()
   require("lualine").setup()
end

return M
