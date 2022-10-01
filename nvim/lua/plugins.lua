-- Note that while this list is *mostly* alphabetical, some plugins are moved so that they load
-- before others.
local config_files = {
  "lsp.cmp",
  "lsp.lsp",
  "colorscheme",
  "treesitter",

  "autopairs",
  "bufferline",
  "comment",
  "fidget",
  "gitsigns",
  "illuminate",
  "indent-blankline",
  "keys",
  "nvim-tree",
  "telescope",
  "todo-comments",
  "treesitter-context",
  "trim",
}

for _, file in pairs(config_files) do
  require("config." .. file)
end
