-- When closing buffers, I don't want it to switch to the open nvim tree buffer
-- https://github.com/akinsho/bufferline.nvim/issues/140#issuecomment-888245325
local function closeBuffer()
  local treeView = require("nvim-tree.view")
  local bufferline = require("bufferline")

  -- check if NvimTree window was open
  local explorerWindow = treeView.get_winnr()
  local wasExplorerOpen = vim.api.nvim_win_is_valid(explorerWindow)

  local bufferToDelete = vim.api.nvim_get_current_buf()

  if wasExplorerOpen then
    -- switch to previous buffer (tracked by bufferline)
    bufferline.cycle(-1)
  end

  -- delete initially open buffer
  vim.cmd("bdelete! " .. bufferToDelete)
end

require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    close_command = closeBuffer,

    -- https://github.com/akinsho/bufferline.nvim#sidebar-offset-1
    offsets = {
      {
        filetype = "NvimTree",
        -- text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})
