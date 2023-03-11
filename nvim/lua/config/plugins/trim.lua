local M = {
   "cappyzawa/trim.nvim",
}

function M.config()
   require("trim").setup({
      ft_blocklist = {},
      patterns = {
         [[%s/\s\+$//e]], -- remove unwanted spaces
         [[%s/\($\n\s*\)\+\%$//]], -- trim last line
         [[%s/\%^\n\+//]], -- trim first line
      },
   })
end

return M
