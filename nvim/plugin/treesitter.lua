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
    "helm",
    "html",
    "http",
    "ini",
    "java",
    "javascript",
    "jq",
    "json",
    "json5",
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

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            require("nvim-treesitter.install").update({ max_jobs = max_jobs })
        end
    end,
})

vim.pack.add({ {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
} })

-- Ensure all parsers in `parsers_to_install` have been installed. If a parser is already
-- installed, install() should skip it. This should run asynchronously.
require("nvim-treesitter.install").install(parsers_to_install, { max_jobs = max_jobs })
