local nvim_lsp = require('lspconfig')

-- Map function used to create keybinds in custom_on_attach below
local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true });
end

-- Custom on_attach function that can be added to each language server
-- Enables the completion plugin and LSP-specific keybinds
local custom_on_attach = function(_, bufnr)
    require('completion').on_attach()
    -- Declaration is not supported by all language servers
    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
end

-- Diagnostics settings (See ":h vim.lsp.diagnostics")
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Using a linter with this enabled can be really annoying
        underline = false,
        -- By default, diagnostics will only be shown once you leave insert
        update_in_insert = true
    }
)

-- Golang: gopls language server
nvim_lsp.gopls.setup{
    on_attach = custom_on_attach
}

-- Linters/Formatters: diagnostic-languageserver
-- Currently being used for revive (go linter)
nvim_lsp.diagnosticls.setup{
    on_attach = custom_on_attach,
    filetypes = { "go" },
    init_options = {
        linters = {
            revive = {
                sourceName = "revive",
                command = "revive",
                args = { "-formatter", "json", "%file" },
                rootPatterns = { ".git", "go.mod" },
                debounce = 100,
                parseJson = {
                    line = "Position.Start.Line",
                    column = "Position.Start.Column",
                    endLine = "Position.End.Line",
                    endColumn = "Position.End.Column",
                    message = "[revive] ${Failure} [${RuleName}]",
                    security = "Severity"
                },
                securities = {
                    warning = "warning",
                    error = "error"
                }
            }
        },
        filetypes = {
            go = "revive"
        }
    }
}
