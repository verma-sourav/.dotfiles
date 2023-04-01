local M = {}

function M.setup_null_ls(options)
   local mason_nls = require("mason-null-ls")
   local nls = require("null-ls")
   local util = require("util")

   local sources = {
      nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.stylua,
   }

   if util.executable("clang-format-10") then
      table.insert(sources, nls.builtins.formatting.clang_format.with({ command = "clang-format-10" }))
   end

   nls.setup({
      on_attach = options.on_attach,
      sources = sources,
   })

   mason_nls.setup({
      ensure_installed = nil,
      automatic_installation = true,
      automatic_setup = false,
   })
end

function M.setup_mason_lsp()
   require("mason").setup()
   require("mason-lspconfig").setup({ automatic_installation = true })
end

return M
