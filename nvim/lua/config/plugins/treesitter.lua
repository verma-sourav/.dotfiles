local M = {
   "nvim-treesitter/nvim-treesitter",
   dependencies = {},
   build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
   end,
}

function M.config()
   require("nvim-treesitter.configs").setup({
      auto_install = true,
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
         additional_vim_regex_highlighting = false,
      },
      indent = {
         enable = true,
         disable = { "yaml" },
      },
   })
end

return M
