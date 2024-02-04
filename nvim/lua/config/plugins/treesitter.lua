return {
   "nvim-treesitter/nvim-treesitter",
   build = function()
      require("nvim-treesitter.install").update()()
   end,
   config = function()
      require("nvim-treesitter.configs").setup({
         auto_install = true,
         ensure_installed = {
            "bash",
            "c",
            "cmake",
            "comment",
            "cpp",
            "css",
            "csv",
            "diff",
            "dockerfile",
            "fish",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "gomod",
            "html",
            "http",
            "ini",
            "java",
            "javascript",
            "jq",
            "json",
            "json5",
            "jsonc",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "pem",
            "printf",
            "proto",
            "python",
            "regex",
            "requirements",
            "rst",
            "rust",
            "sql",
            "toml",
            "vimdoc",
            "yaml",
         },
         highlight = {
            -- False will disable the whole extension
            enable = true,
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
         },
         indent = {
            enable = true,
            disable = { "yaml" },
         },
      })
   end,
}
