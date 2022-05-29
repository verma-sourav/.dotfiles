-- Even though the plugins are all installed on first launch, it seems that the colorscheme can have
-- some issues being set on the first launch. If the command fails, we will just fall back to the
-- default.
vim.cmd([[
  try
  colorscheme tokyonight
  catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
  endtry
]])

  vim.g.lightline = { colorscheme = 'tokyonight' }
