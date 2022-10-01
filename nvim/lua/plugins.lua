local config_files = {
  "autopairs",
  "bufferline",
  "lsp.cmp",
  "colorscheme",
  "comment",
  "fidget",
  "gitsigns",
  "illuminate",
  "indent-blankline",
  "keys",
  "lsp.lsp",
  "nvim-tree",
  "telescope",
  "treesitter",
  "treesitter-context",
  "trim",
}

for _, file in pairs(config_files) do
  require("config." .. file)
end
