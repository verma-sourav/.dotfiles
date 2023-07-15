local M = {
   "neovim/nvim-lspconfig",
   event = "BufReadPre",
   dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
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
   },
}

local function import(pkg)
   return require("config.plugins.lsp." .. pkg)
end

-- Currently clangd uses utf-8, while null-ls formatters use utf-16. Neovim cannot support multiple
-- offset encodings in the same file like that, so it will throw errors if we don't do this.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
local function get_clang_capabilities()
   local cap = require("cmp_nvim_lsp").default_capabilities()
   cap.offsetEncoding = { "utf-16" }
   return cap
end

local function merge_tables(base, addl)
   return vim.tbl_deep_extend("force", {}, base, addl or {})
end

local default_on_attach = function(client, bufnr)
   import("formatting").setup(client, bufnr)
   import("keymaps").setup(client, bufnr)
end

local function setup_language_servers()
   local language_servers = {
      ansiblels = {},
      bashls = {},
      clangd = {
         capabilities = get_clang_capabilities(),
      },
      dockerls = {},
      gopls = {},
      html = {},
      jsonls = {},
      pyright = {},
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
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = default_on_attach,
   }

   local lspconfig = require("lspconfig")
   for server, custom_options in pairs(language_servers) do
      local opts = merge_tables(default_options, custom_options)
      lspconfig[server].setup(opts)
   end
end

local function setup_formatters()
   local nls = require("null-ls")
   local formatters = nls.builtins.formatting

   local sources = {
      formatters.black.with({ extra_args = { "--fast" } }),
      formatters.goimports,
      formatters.stylua,
   }

   if require("util").executable("clang-format-10") then
      table.insert(sources, formatters.clang_format.with({ command = "clang-format-10" }))
   end

   nls.setup({
      on_attach = default_on_attach,
      sources = sources,
   })

   require("mason-null-ls").setup({
      ensure_installed = nil,
      automatic_installation = true,
   })
end

function M.config()
   import("completion").setup()
   require("mason").setup()
   require("mason-lspconfig").setup({ automatic_installation = true })
   setup_language_servers()
   setup_formatters()
end

return M
