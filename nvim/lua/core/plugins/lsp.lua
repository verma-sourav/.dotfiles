local util = require("core.utils")
local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "stevearc/conform.nvim",
        "j-hui/fidget.nvim",
    },
}

function M.config()
    require("fidget").setup()
    M.setup_conform()
    require("mason").setup()
    require("mason-lspconfig").setup({ automatic_installation = true })
    require("mason-tool-installer").setup({
        -- Conform doesn't have automatic installation like null-ls did, so for now I'm
        -- explicitly listing out the formatters configured with conform.
        ensure_installed = { "stylua", "goimports" },
    })
    M.setup_language_servers()
end

function M.setup_conform()
    local conform = require("conform")
    conform.setup({
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports" },
        },
    })

    if util.executable("clang-format-10") then
        conform.formatters.clang_format = { command = "clang-format-10" }
        conform.formatters_by_ft.cpp = { "clang_format" }
    end
end

function M.setup_language_servers()
    local language_servers = {
        ansiblels = {},
        bashls = {},
        clangd = {
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
        cssls = {},
        dockerls = {},
        golangci_lint_ls = {},
        gopls = {},
        html = {},
        jsonls = {},
        pyright = {},
        ruff = {},
        sqlls = {},
        ts_ls = {},
        vimls = {},
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        },
    }

    local default_options = {
        capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("blink.cmp").get_lsp_capabilities()
        ),
    }

    local lspconfig = require("lspconfig")
    for server, custom_options in pairs(language_servers) do
        local opts = util.merge_tables(default_options, custom_options)
        lspconfig[server].setup(opts)
    end
end

return M
