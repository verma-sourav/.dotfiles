return {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "debugloop/telescope-undo.nvim",
   },
   config = function()
      local telescope = require("telescope")
      local open_with_trouble = require("trouble.sources.telescope").open
      local add_to_trouble = require("trouble.sources.telescope").add
      telescope.setup({
         defaults = {
            vimgrep_arguments = {
               "rg",
               "--color=never",
               "--no-heading",
               "--with-filename",
               "--line-number",
               "--column",
               "--smart-case",
            },
            mappings = {
               i = { ["<C-t>"] = open_with_trouble, ["<M-t>"] = add_to_trouble },
               n = { ["<C-t>"] = open_with_trouble, ["<M-t>"] = add_to_trouble },
            },
         },
      })
      telescope.load_extension("fzy_native")
      telescope.load_extension("undo")
   end,
}
