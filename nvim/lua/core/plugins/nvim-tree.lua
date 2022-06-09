local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

nvim_tree.setup({
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
      resize_window = true
    }
  },
})
