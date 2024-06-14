local M = {
   "hrsh7th/nvim-cmp",
   dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
   },
}

function M.config()
   local cmp = require("cmp")

   cmp.setup({
      window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
      },
      formatting = {
         format = require("lspkind").cmp_format(),
      },
      mapping = cmp.mapping.preset.insert({
         ["<C-e>"] = cmp.mapping.abort(),
         ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      }),
      snippet = {
         expand = function(args)
            require("luasnip").lsp_expand(args.body)
         end,
      },
      sources = cmp.config.sources({
         { name = "luasnip" },
         { name = "nvim_lsp" },
         { name = "nvim_lsp_signature_help" },
      }, {
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

return M
