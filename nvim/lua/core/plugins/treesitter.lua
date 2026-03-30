local max_jobs = vim.uv.available_parallelism()
local parsers_to_install = {
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
    "svelte",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
}

local function get_missing_parsers()
    local installed = require("nvim-treesitter.config").get_installed()
    return vim.iter(parsers_to_install)
        :filter(function(parser)
            return not vim.tbl_contains(installed, parser)
        end)
        :totable()
end

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function()
        require("nvim-treesitter.install").update({ max_jobs = max_jobs })
    end,
    -- If you pass an already-installed parser, the treesitter plugin won't install it, but it
    -- will still print a message as if it did. This is apparently as designed, so now we get
    -- to filter it out ourselves to avoid that I guess.
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/7872#issuecomment-2902640531
    config = function()
        local missing = get_missing_parsers()
        require("nvim-treesitter.install").install(missing, { max_jobs = max_jobs })
    end,
}
