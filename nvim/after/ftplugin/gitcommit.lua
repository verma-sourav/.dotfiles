local group = vim.api.nvim_create_augroup("gitcommit", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  desc = "Enable spell checking",
  pattern = "gitcommit",
  command = "setlocal spell",
})
