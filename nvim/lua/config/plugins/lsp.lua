local util = require("util")
local wk = require("which-key")

local function setup_cmp()
   local cmp = require("cmp")

   cmp.setup({
      window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
         ["<C-f>"] = cmp.mapping.scroll_docs(4),
         ["<C-Space>"] = cmp.mapping.complete(),
         ["<C-e>"] = cmp.mapping.abort(),
         ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      }),
      snippet = {
         expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      sources = cmp.config.sources({
         { name = "nvim_lsp" },
         { name = "nvim_lua" },
         { name = "luasnip" },
         { name = "path" },
         { name = "buffer", keyword_length = 4 },
      }),
   })

   cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
         { name = "buffer" },
      },
   })

   cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
         { name = "path" },
         { name = "cmdline", keyword_length = 2 },
      }),
   })
end

local function setup_conform()
   local conform = require("conform")
   conform.setup({
      format_on_save = {
         timeout_ms = 500,
         lsp_fallback = true,
      },
      formatters_by_ft = {
         lua = { "stylua" },
         python = { "ruff_format" },
         go = { "goimports" },
      },
   })

   if util.executable("clang-format-10") then
      conform.formatters.clang_format = { command = "clang-format-10" }
      conform.formatters_by_ft.cpp = { "clang_format" }
   end
end

local function setup_language_servers()
   local cmp_lsp = require("cmp_nvim_lsp")
   local language_servers = {
      ansiblels = {},
      bashls = {},
      clangd = {},
      dockerls = {},
      golangci_lint_ls = {},
      gopls = {},
      html = {},
      jsonls = {},
      ruff_lsp = {},
      sqlls = {},
      vimls = {},
      lua_ls = {
         settings = {
            Lua = {
               diagnostics = { globals = { "vim" } },
            },
         },
      },
   }

   local default_options = {
      capabilities = vim.tbl_deep_extend(
         "force",
         {},
         vim.lsp.protocol.make_client_capabilities(),
         cmp_lsp.default_capabilities()
      ),
   }

   local lspconfig = require("lspconfig")
   for server, custom_options in pairs(language_servers) do
      local opts = util.merge_tables(default_options, custom_options)
      lspconfig[server].setup(opts)
   end
end

return {
   "neovim/nvim-lspconfig",
   dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "stevearc/conform.nvim",
      "j-hui/fidget.nvim",

      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
   },

   config = function()
      require("fidget").setup()
      setup_cmp()
      setup_conform()
      require("mason").setup()
      require("mason-lspconfig").setup({ automatic_installation = true })
      require("mason-tool-installer").setup({
         -- Conform doesn't have automatic installation like null-ls did, so for now I'm
         -- explicitly listing out the formatters configured with conform.
         ensure_installed = { "stylua", "goimports", "ruff" },
      })
      setup_language_servers()
   end,
}
