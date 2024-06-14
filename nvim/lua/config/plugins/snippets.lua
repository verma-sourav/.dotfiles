local util = require("util")
return {
   "L3MON4D3/LuaSnip",
   config = function()
      for _, path in ipairs(vim.api.nvim_get_runtime_file("lua/config/snippets/*.lua", true)) do
         loadfile(path)()
      end

      for _, path in ipairs(util.glob("~/.config/dots/snippets/*.lua")) do
         loadfile(path)()
      end
   end,
}
