local M = {
   "tzachar/local-highlight.nvim",
}

function M.config()
   -- The plugin uses the CursorHold event to determine when to start showing highlights which in
   -- turn relies on updatetime. The default is 4000ms which is fairly long so this drops it down
   -- to be more responsive. Because swap files are disabled, this change shouldn't affect that
   -- (since updatetime also determines when to write swap files to disk).
   vim.opt.updatetime = 500
   require("local-highlight").setup({
      hlgroup = "Visual",
   })
end

return M
