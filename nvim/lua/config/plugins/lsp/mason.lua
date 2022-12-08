local M = {}

function M.setup()
   require("mason").setup()
   require("mason-lspconfig").setup({ automatic_installation = true })
end

return M
