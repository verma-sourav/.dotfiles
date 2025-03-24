return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
        keymap = { preset = "super-tab" },
        appearance = { nerd_font_variant = "mono" },
        signature = { enabled = true },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                snippets = {
                    opts = {
                        search_paths = {
                            vim.fn.stdpath("config") .. "/snippets",
                            vim.fn.glob("~/.config/dots/nvim/snippets"),
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
    },
    opts_extend = { "sources.default" },
}
