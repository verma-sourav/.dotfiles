local markdown = vim.api.nvim_create_augroup('markdown', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = markdown,
  desc = 'Enable spell checking',
  pattern = 'markdown',
  command = 'setlocal spell',
})

local gitcommit = vim.api.nvim_create_augroup('gitcommit', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = gitcommit,
  desc = 'Enable spell checking',
  pattern = 'gitcommit',
  command = 'setlocal spell',
})

local highlight_yank = vim.api.nvim_create_augroup('highlight_yank', { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank,
  desc = 'Highlight text when yanked',
  pattern = '*',
  command = "silent! lua require'vim.highlight'.on_yank({timeout = 200})",
})

local format_options = vim.api.nvim_create_augroup('format_options', { clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = format_options,
  desc = 'Set format options for all file types',
  pattern = '*',
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
      + 'c' -- Comments respect textwidth
      + 'j' -- Auto-remove comments when joining together two lines
      - 'r' -- Don't automatically continue comment when I hit ender
      - 'o' -- Don't automatically continue comment when using o/O
  end
})
