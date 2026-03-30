return {
    "saghen/blink.cmp",
    version = "*",
    opts = {
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
