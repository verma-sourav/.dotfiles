vim.pack.add({ {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
} })

require("blink-cmp").setup({
    keymap = { preset = "super-tab" },
    appearance = { nerd_font_variant = "mono" },
    signature = { enabled = true },
    completion = { documentation = { auto_show = true } },
    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
            cmdline = {
                -- Stop freezes when using :! on WSL
                -- https://github.com/Saghen/blink.cmp/issues/795
                -- https://github.com/Saghen/blink.cmp/pull/1167
                enabled = function()
                    return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                end,
            },
            snippets = {
                opts = {
                    search_paths = {
                        vim.fn.stdpath("config") .. "/snippets",
                        require("utils").machine_config.snippets,
                    },
                },
            },
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },
        },
    },
})
