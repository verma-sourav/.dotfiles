local M = {
   "j-hui/fidget.nvim",
}

function M.config()
   require("fidget").setup({ text = { spinner = "dots" } })
end

return M
