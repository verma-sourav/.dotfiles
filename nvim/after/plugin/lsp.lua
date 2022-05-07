require("nvim-lsp-installer").setup {
  -- Detect which servers to install based on which servers are set up via lspconfig
  automatic_installation = true
}

local lspconfig = require('lspconfig')
lspconfig.ansiblels.setup({})
lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
lspconfig.dockerls.setup({})
lspconfig.gopls.setup({})
lspconfig.golangci_lint_ls.setup({})
lspconfig.html.setup({})
lspconfig.jsonls.setup({})
lspconfig.pyright.setup({})
lspconfig.sqls.setup({})
lspconfig.vimls.setup({})

lspconfig.sumneko_lua.setup({
  settings = {
      Lua = {
          diagnostics = { globals = { 'vim' } }
      }
  }
})
