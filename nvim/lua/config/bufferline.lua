-- https://github.com/akinsho/bufferline.nvim
require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",

    -- When closing buffers, I don't want it to switch to the open nvim tree buffer
    close_command = function(bufnum)
      require("bufdelete").bufdelete(bufnum, false)
    end,

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
