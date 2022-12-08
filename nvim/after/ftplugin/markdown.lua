vim.opt_local.colorcolumn = "100"

local group = vim.api.nvim_create_augroup("markdown", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
   group = group,
   desc = "Enable spell checking",
   pattern = "markdown",
   command = "setlocal spell",
})
