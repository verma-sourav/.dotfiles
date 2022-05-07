require("nvim-lsp-installer").setup {
  -- Detect which servers to install based on which servers are set up via lspconfig
  automatic_installation = true
}

-- nvim-cmp-lsp needs to be a client of LSPs to provde completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
local function default_setup(server)
  lspconfig[server].setup({capabilities = capabilities})
end

default_setup('ansiblels')
default_setup('bashls')
default_setup('clangd')
default_setup('dockerls')
default_setup('gopls')
default_setup('golangci_lint_ls')
default_setup('html')
default_setup('jsonls')
default_setup('pyright')
default_setup('sqls')
default_setup('vimls')

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  settings = {
      Lua = {
          diagnostics = { globals = { 'vim' } }
      }
  }
})
