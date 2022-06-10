local ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

treesitter_configs.setup({
  -- Can be "all" or a list of parsers.
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "dart",
    "dockerfile",
    "fish",
    "go",
    "gomod",
    "gowork",
    "help",
    "hjson",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "kotlin",
    "latex",
    "lua",
    "make",
    "perl",
    "proto",
    "python",
    "regex",
    "rst",
    "ruby",
    "rust",
    "scss",
    "todotxt",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },

  highlight = {
    -- False will disable the whole extension
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
})
