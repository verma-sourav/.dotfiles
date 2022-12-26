local M = {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
   },
}

-- The telescope styling done in this config is a mix of the following:
-- https://www.reddit.com/r/neovim/comments/se377t/comment/hukpurs/?utm_source=share&utm_medium=web2x&context=3
-- https://www.reddit.com/r/neovim/comments/xcsatv/comment/iq32go0/?utm_source=share&utm_medium=web2x&context=3
function M.config()
   local telescope = require("telescope")
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
         prompt_prefix = "   ",
         selection_caret = "  ",
         entry_prefix = "  ",
         initial_mode = "insert",
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
         file_sorter = require("telescope.sorters").get_fuzzy_file,
         file_ignore_patterns = { "node_modules" },
         generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
         path_display = { "truncate" },
         winblend = 0,
         border = {},
         borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
         color_devicons = true,
         use_less = true,
         set_env = { ["COLORTERM"] = "truecolor" },
         file_previewer = require("telescope.previewers").vim_buffer_cat.new,
         grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
         qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
         -- Developer configurations: Not meant for general override
         buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
   })
   telescope.load_extension("fzy_native")

   local colors = require("catppuccin.palettes").get_palette()
   local TelescopeColor = {
      TelescopeMatching = { fg = colors.flamingo },
      TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

      TelescopePromptPrefix = { bg = colors.surface0 },
      TelescopePromptNormal = { bg = colors.surface0 },
      TelescopeResultsNormal = { bg = colors.mantle },
      TelescopePreviewNormal = { bg = colors.mantle },
      TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
      TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
      TelescopeResultsTitle = { fg = colors.mantle },
      TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
   }

   for hl, col in pairs(TelescopeColor) do
      vim.api.nvim_set_hl(0, hl, col)
   end
end

return M
