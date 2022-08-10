-- When closing buffers, I don't want it to switch to the open nvim tree buffer
-- https://github.com/akinsho/bufferline.nvim/issues/140#issuecomment-888245325
local function close_buffer(bufnum)
  local bufferline = require("bufferline")

  -- Check if NvimTree widnow was open
  local tree = require("nvim-tree.view").get_winnr()
  local was_open = vim.api.nvim_win_is_valid(tree)
  if was_open then
    bufferline.cycle(-1)
  end

  -- Actually delete the buffer
  vim.cmd("bdelete! " .. bufnum)
end

require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    close_command = close_buffer,

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
