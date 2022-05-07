local markdown = vim.api.nvim_create_augroup('markdown', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = markdown,
  pattern = 'markdown',
  command = 'setlocal spell',
  desc = 'Enable spell checking'
})

local gitcommit = vim.api.nvim_create_augroup('gitcommit', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = gitcommit,
  pattern = 'gitcommit',
  command = 'setlocal spell',
  desc = 'Enable spell checking'
})

local highlight_yank = vim.api.nvim_create_augroup('highlight_yank', { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank,
  pattern = '*',
  command = "silent! lua require'vim.highlight'.on_yank({timeout = 200})",
  desc = 'Highlight text when yanked'
})
