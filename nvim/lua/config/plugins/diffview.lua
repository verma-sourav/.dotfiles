local M = {
   "sindrets/diffview.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
   },
}

-- Diffview is not going to add a toggle function, so this was the approach recommended by the
-- creator: https://github.com/sindrets/diffview.nvim/issues/188#issuecomment-1217931407
local function toggle(e)
   local view = require("diffview.lib").get_current_view()
   if view then
      vim.cmd("DiffviewClose")
   else
      vim.cmd("DiffviewOpen " .. e.args)
   end
end

function M.config()
   vim.api.nvim_create_user_command("DiffviewToggle", toggle, { nargs = "*" })
end

return M
