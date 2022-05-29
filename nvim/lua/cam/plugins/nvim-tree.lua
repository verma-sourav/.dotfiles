local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

nvim_tree.setup({
  actions = {
    open_file = {
      resize_window = true
    }
  }
})
