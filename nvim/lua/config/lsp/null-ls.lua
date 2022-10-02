local M = {}

function M.setup(options)
  local nls = require("null-ls")
  nls.setup({
    on_attach = options.on_attach,
    sources = {
      nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.stylua,
    },
  })
end

return M
