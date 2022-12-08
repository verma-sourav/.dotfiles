local M = {
   "folke/trouble.nvim",
   dependencies = {
      "kyazdani42/nvim-web-devicons",
   },
}

function M.config()
   require("trouble").setup()
end

return M
