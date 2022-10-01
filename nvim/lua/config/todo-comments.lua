-- https://github.com/folke/todo-comments.nvim
-- Highlight, list, and search comments
require("todo-comments").setup({
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- Regex that will be used to match keywords.
    -- By default the plguin requires a `:` after the word to match. This allows it to match without
    -- the extra colon. If I end up getting a lot of false positives I may have to revert this.
    pattern = [[\b(KEYWORDS)\b]],
  },
})
