local M = {}

function M.setup()
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
      }, {
         { name = "cmdline", keyword_length = 2 },
      }),
   })
end

return M
