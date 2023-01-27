local M = {
      "neovim/nvim-lspconfig",
      name = "lsp",
      event = "BufReadPre",
      dependencies = {
         "jose-elias-alvarez/null-ls.nvim",
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
         "ray-x/lsp_signature.nvim",
         {
            "hrsh7th/nvim-cmp",
            dependencies = {
               "L3MON4D3/LuaSnip",
               "hrsh7th/cmp-nvim-lsp",
               "hrsh7th/cmp-nvim-lua",
               "hrsh7th/cmp-path",
               "hrsh7th/cmp-buffer",
               "hrsh7th/cmp-cmdline",
               "saadparwaiz1/cmp_luasnip",
               "onsails/lspkind.nvim",
            },
         },
   }
}

local function import(pkg)
   return require("config.plugins.lsp." .. pkg)
end

function M.config()
   import("completion").setup()
   import("mason").setup()

   -- nvim-cmp-lsp needs to be a client of LSPs to provde completion
   local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

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
         import("formatting").setup(client, bufnr)
         import("keymaps").setup(client, bufnr)
         import("lsp-signature").setup(bufnr)
      end,

      capabilities = default_capabilities,
   }

   local lspconfig = require("lspconfig")
   for server, opts in pairs(servers) do
      opts = vim.tbl_deep_extend("force", {}, options, opts or {})
      lspconfig[server].setup(opts)
   end

   import("null-ls").setup(options)
end

return M
