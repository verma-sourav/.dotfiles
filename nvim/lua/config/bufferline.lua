-- When closing buffers, I don't want it to switch to the open nvim tree buffer
local function close_buffer(bufnum)
  require("bufdelete").bufdelete(bufnum, false)
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
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})
