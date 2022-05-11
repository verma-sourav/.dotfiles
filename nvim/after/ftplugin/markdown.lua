vim.opt_local.formatoptions = vim.opt_local.formatoptions
  + 't' -- Auto-wrap text using textwidth
  - 'l' -- Allow long lines to be rewrapped when entering insert mode (we'll see how this goes)
vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = '80'
