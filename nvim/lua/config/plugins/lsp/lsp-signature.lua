local M = {}

function M.setup(bufnr)
   local settings = {
      -- Bind is required to register the border config
      bind = true,
      -- Enable a floating window
      handler_opts = {
        border = "rounded"
      },
   }

   require("lsp_signature").on_attach(settings, bufnr)
end

return M
