-- https://github.com/hrsh7th/nvim-cmp
-- nvim-cmp provides auto-completion from various sources (LSP, snippets, etc.)

-- This config file also contains logic to setup the various sources and helper plugins:
-- https://github.com/onsails/lspkind.nvim (LSP pictograms like vscode)
-- https://github.com/L3MON4D3/LuaSnip (Snippet engine for neovim)
-- https://github.com/hrsh7th/cmp-buffer (Completion source for buffer words)
-- https://github.com/hrsh7th/cmp-cmdline (Completion source for vim's command line)
-- https://github.com/hrsh7th/cmp-nvim-lsp (Completion source for the nvim LSP)
-- https://github.com/hrsh7th/cmp-nvim-lua (Completion source for the nvim Lua API)
-- https://github.com/hrsh7th/cmp-path (Completion source for filesystem paths)
-- https://github.com/saadparwaiz1/cmp_luasnip (Completion source for LuaSnip)

local cmp = require("cmp")
local lspkind = require("lspkind")

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

  experimental = {
    native_menu = false,
    ghost_text = true,
  },

  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lua = "[lua]",
        luasnip = "[snip]",
        path = "[path]",
        buffer = "[buf]",
      },
    }),
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 4 },
  }),
})

cmp.setup.cmdline(":", {
  sources = {
    { name = "cmdline", keyword_length = 3 },
  },
})
