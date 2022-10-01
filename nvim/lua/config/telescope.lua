-- https://github.com/nvim-telescope/telescope.nvim
-- A highly-extensible fuzzy finder for neovim
local telescope = require("telescope")
telescope.setup({
  defaults = {
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    winblend = 0,
    color_devicons = true,
    use_less = true,
  },
})
telescope.load_extension("fzy_native")
