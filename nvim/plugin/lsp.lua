vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/qvalentin/helm-ls.nvim",
})

local js_formatters = { "oxfmt", "prettierd", "prettier", stop_after_first = true }
local formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports" },
    json = { "oxfmt", lsp_format = "fallback", stop_after_first = true },
    html = { "oxfmt", lsp_format = "fallback", stop_after_first = true },
    javascript = js_formatters,
    typescript = js_formatters,
    javascriptreact = js_formatters,
    typescriptreact = js_formatters,
}

require("fidget").setup({})
require("mason").setup({})
require("conform").setup({
    default_format_opts = { lsp_format = "never", timeout_ms = 3000 },
    formatters_by_ft = formatters_by_ft,
    formatters = {
        oxfmt = {
            -- Only use oxfmt if the config file exists. In the future I could check package.json.
            require_cwd = true,
            cwd = require("conform.util").root_file({ ".oxlintrc.json", "oxlint.config.ts" }),
        },
    },
})
require("helm-ls").setup({
    conceal_templates = {
        enabled = true, -- Replace templates with virtual text of their current value
    },
    indent_hints = {
        enabled = true,
        only_for_current_line = true,
    },
    action_highlight = {
        enabled = true,
    },
})
require("mason-lspconfig").setup({
    automatic_enable = true,
    ensure_installed = {
        "ansiblels",
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "helm_ls",
        "html",
        "jsonls",
        "lua_ls",
        "oxfmt",
        "ruff",
        "sqlls",
        "svelte",
        "ts_ls",
        "ty",
        "vimls",
        "yamlls",
    },
})

-- Ensure formatters are installed via Mason. This runs in the background to avoid blocking startup.
local registry = require("mason-registry")
registry.refresh(vim.schedule_wrap(function()
    local to_install = { ["golangci-lint"] = 1 }

    for _, formatters in pairs(formatters_by_ft) do
        if type(formatters) ~= "table" then
            break
        end

        for _, formatter in ipairs(formatters) do
            to_install[formatter] = 1
        end
    end

    for tool, _ in pairs(to_install) do
        local package = registry.get_package(tool)
        if not package:is_installed() and not package:is_installing() then
            vim.notify(("[dots] Installing with mason: %s"):format(package))
            package:install()
        end
    end
end))
