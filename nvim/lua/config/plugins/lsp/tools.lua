local M = {}

function M.setup_null_ls()
   local mason_nls = require("mason-null-ls")
   local nls = require("null-ls")
   local util = require("util")

   -- https://github.com/jay-babu/mason-null-ls.nvim#primary-source-of-truth-is-mason-null-ls
   mason_nls.setup({
      ensure_installed = {
         "black",
         "goimports",
         "golangci_lint",
         "stylua",
      },
      automatic_installation = false,
      automatic_setup = true,
   })

   local non_mason_sources = {}
   if util.executable("clang-format-10") then
      table.insert(non_mason_sources, nls.builtins.formatting.clang_format.with({ command = "clang-format-10" }))
   end

   nls.setup({ sources = non_mason_sources })
   mason_nls.setup_handlers()
end

function M.setup()
   require("mason").setup()
   require("mason-lspconfig").setup({ automatic_installation = true })
   M.setup_null_ls()
end

return M
