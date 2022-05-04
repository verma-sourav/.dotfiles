local groupMarkdown = vim.api.nvim_create_augroup('Markdown', { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = groupMarkdown,
    pattern = 'markdown',
    command = 'setlocal spell',
    desc = 'Enable spell checking'
})

local groupGitCommit = vim.api.nvim_create_augroup('Git Commit', { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = groupGitCommit,
    pattern = 'gitcommit',
    command = 'setlocal spell',
    desc = 'Enable spell checking'
})

local groupHighlightYank = vim.api.nvim_create_augroup('Highlight Yank', { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = groupHighlightYank,
    pattern = '*',
    command = "silent! lua require'vim.highlight'.on_yank({timeout = 200})",
    desc = 'Highlight text when yanked'
})
