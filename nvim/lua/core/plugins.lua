local config_files = {
  'autopairs',
  'bufferline',
  'cmp',
  'colorscheme',
  'comment',
  'gitsigns',
  'indent-blankline',
  'lsp',
  'notify',
  'nvim-tree',
  'telescope',
  'treesitter',
  'treesitter-context',
  'trim'
}

for _, file in pairs(config_files) do
  require('core.plugins.' .. file)
end
