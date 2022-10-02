-- This file sets up a few plugins that help manage the LSP, language server configs, and LSP binaries
-- https://github.com/neovim/nvim-lspconfig (Quickstart configs for nvim's LSP)
-- https://github.com/williamboman/mason.nvim (Package manager for nvim - LSPs, linters, formatters)
-- https://github.com/williamboman/mason-lspconfig.nvim (Extension for mason.nvim and nvim-lspconfig)
-- https://github.com/jose-elias-alvarez/null-ls.nvim (Used to inject extra LSPs, formatters, etc)

require("config.lsp.cmp")
require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

local servers = {
  ansiblels = {},
  bashls = {},
  clangd = {},
  dockerls = {},
  gopls = {},
  golangci_lint_ls = {},
  html = {},
  jsonls = {},
  pyright = {},
  sqls = {},
  vimls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
      },
    },
  },
}

local options = {
  on_attach = function(client, bufnr)
    -- For certain language servers I'm disabling their formatting capabilities so that another
    -- formatter can be used (usually set up in null-ls). If there are multiple formatters for
    -- a file type, neovim will open a popup on save asking which one to use.
    if client.name == "gopls" or client.name == "sumneko_lua" then
      client.server_capabilities.documentFormattingProvider = false
    end

    require("config.lsp.formatting").setup(client, bufnr)
    require("config.lsp.keys").setup(client, bufnr)
  end,

  -- nvim-cmp-lsp needs to be a client of LSPs to provde completion
  capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

for server, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {}, options, opts or {})
  require("lspconfig")[server].setup(opts)
end

require("config.lsp.null-ls").setup(options)
