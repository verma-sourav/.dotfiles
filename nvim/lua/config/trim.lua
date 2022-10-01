-- https://github.com/cappyzawa/trim.nvim
-- Trim trailing whitespace and lines
require("trim").setup({
  disable = {},
  patterns = {
    [[%s/\s\+$//e]], -- remove unwanted spaces
    [[%s/\($\n\s*\)\+\%$//]], -- trim last line
    [[%s/\%^\n\+//]], -- trim first line
  },
})
