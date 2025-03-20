-- Remove one or more lines from the current quickfix list. If this is called when in normal mode,
-- the line under the cursor will be removed. If in visual mode, all selected lines will be
-- removed.
-- Based on:
-- https://www.reddit.com/r/neovim/comments/1c6tcyl/best_way_to_remove_things_from_qflist/
-- https://github.com/benlubas/.dotfiles/blob/ead34f267708d40739ea93c556b6b37f605bb148/nvim/after/ftplugin/qf.lua
-- https://github.com/rmarganti/.dotfiles/blob/283a8ad23189b85caf892044b74aa38be742d51f/dots/.config/nvim/lua/rmarganti/core/autocommands.lua#L53
local function delete_quickfix_items()
   local mode = vim.api.nvim_get_mode()["mode"]

   local start_index
   local count

   if mode == "n" then
      -- Normal mode
      start_index = vim.fn.line(".")
      count = vim.v.count > 0 and vim.v.count or 1
   else
      -- Visual mode
      local visual_start = vim.fn.line("v")
      local visual_end = vim.fn.line(".")

      start_index = math.min(visual_start, visual_end)
      count = math.abs(visual_end - visual_start) + 1

      -- Switch back to normal mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
   end

   local current_quickfix = vim.fn.getqflist()

   for _ = 1, count, 1 do
      table.remove(current_quickfix, start_index)
   end

   vim.fn.setqflist(current_quickfix, "r")
   vim.fn.cursor(start_index, 1)
end

-- Mimic the normal keymaps to delete lines when editing a file
vim.keymap.set("n", "dd", delete_quickfix_items, { buffer = true })
vim.keymap.set("v", "d", delete_quickfix_items, { buffer = true })
