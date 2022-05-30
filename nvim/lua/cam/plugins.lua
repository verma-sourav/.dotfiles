local config_files = {
  'autopairs',
  'cmp',
  'colorscheme',
  'comment',
  'gitsigns',
  'lsp',
  'neoscroll',
  'notify',
  'nvim-tree',
  'telescope',
  'treesitter',
  'trim'
}

for _, file in pairs(config_files) do
  require('cam.plugins.' .. file)
end
