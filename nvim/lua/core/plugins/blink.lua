return {
   "saghen/blink.cmp",
   version = "*",
   opts = {
      keymap = { preset = "super-tab" },
      appearance = { nerd_font_variant = "mono" },
      signature = { enabled = true },
      sources = {
         default = { "lsp", "path", "snippets", "buffer" },
         providers = {
            snippets = {
               opts = {
                  search_paths = {
                     vim.fn.stdpath("config") .. "/snippets",
                     vim.fn.glob("~/.config/dots/nvim/snippets"),
                  },
               },
            },
         },
      },
   },
   opts_extend = { "sources.default" },
}
