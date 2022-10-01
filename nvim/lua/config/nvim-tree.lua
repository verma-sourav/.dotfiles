-- https://github.com/kyazdani42/nvim-tree.lua
-- A file explorer for neovim
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  renderer = {
    add_trailing = false,
    group_empty = true,
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
})
