local M = {
   "lukas-reineke/indent-blankline.nvim",
   main = "ibl",
}

function M.config()
   require("ibl").setup()
end

return M
