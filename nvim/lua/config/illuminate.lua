-- https://github.com/RRethy/vim-illuminate
-- Illuminate highlights other uses of a symbol when you hover over it.

-- The plugin runs without being manually set up, so here I'm just replacing the default underline
-- with an actual highlight.
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
