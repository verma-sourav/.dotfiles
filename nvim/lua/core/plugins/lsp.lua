local lspconfig = {
    "neovim/nvim-lspconfig",
    priority = 100,
    config = function()
        vim.lsp.config("clangd", {
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        })

        -- Servers aren't explicitly enabled here using vim.lsp.enable because mason is handling that.
        -- The servers listed in ensure_installed will be automatically enabled by default.
    end,
}

local conform = {
    "stevearc/conform.nvim",
    priority = lspconfig.priority - 1,
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
            },
        })

        if require("core.utils").executable("clang-format-10") then
            conform.formatters.clang_format = { command = "clang-format-10" }
            conform.formatters_by_ft.cpp = { "clang_format" }
        end
    end,
}

local mason = {
    "williamboman/mason.nvim",
    priority = lspconfig.priority - 1,
    opts = {},
}

local mason_lspconfig = {
    "williamboman/mason-lspconfig.nvim",
    priority = lspconfig.priority - 1,
    opts = {
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
            "html",
            "jsonls",
            "lua_ls",
            "pyright",
            "ruff",
            "sqlls",
            "svelte",
            "ts_ls",
            "vimls",
        },
    },
}

local mason_conform = {
    "zapling/mason-conform.nvim",
    priority = conform.priority - 1,
    opts = {},
}

local fidget = {
    "j-hui/fidget.nvim",
    opts = {},
}

return {
    lspconfig,
    conform,
    mason,
    mason_lspconfig,
    mason_conform,
    fidget,
}
