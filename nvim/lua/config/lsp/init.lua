-- This file sets up a few plugins that help manage the LSP, language server configs, and LSP binaries
-- https://github.com/neovim/nvim-lspconfig (Quickstart configs for nvim's LSP)
-- https://github.com/williamboman/mason.nvim (Package manager for nvim - LSPs, linters, formatters)
-- https://github.com/williamboman/mason-lspconfig.nvim (Extension for mason.nvim and nvim-lspconfig)
-- https://github.com/jose-elias-alvarez/null-ls.nvim (Used to inject extra LSPs, formatters, etc)

require("config.lsp.cmp")
require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

-- nvim-cmp-lsp needs to be a client of LSPs to provde completion
local default_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
-- This encoding forces the client to use utf-16 offset encodings. Currently clangd uses utf-8,
-- while null-ls formatters use utf-16. Neovim cannot support multiple offset encodings in the
-- same file like that, so it will throw errors if we don't do this to clangd.
local utf_16_capabilities = default_capabilities
utf_16_capabilities.offsetEncoding = { "utf-16" }

local servers = {
  ansiblels = {},
  bashls = {},
  clangd = {
    capabilities = utf_16_capabilities,
  },
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
    require("config.lsp.formatting").setup(client, bufnr)
    require("config.lsp.keys").setup(client, bufnr)
  end,

  capabilities = default_capabilities,
}

for server, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {}, options, opts or {})
  require("lspconfig")[server].setup(opts)
end

require("config.lsp.null-ls").setup(options)
