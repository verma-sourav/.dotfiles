local M = {
   "cappyzawa/trim.nvim",
}

function M.config()
   require("trim").setup({
      disable = {},
      patterns = {
         [[%s/\s\+$//e]], -- remove unwanted spaces
         [[%s/\($\n\s*\)\+\%$//]], -- trim last line
         [[%s/\%^\n\+//]], -- trim first line
      },
   })
end

return M
