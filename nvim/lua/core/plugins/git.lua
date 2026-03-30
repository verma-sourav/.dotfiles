return {
    {
        "sindrets/diffview.nvim",
        opts = {
            view = {
                merge_tool = {
                    layout = "diff4_mixed",
                },
            },
        },
    },
    {
        "tpope/vim-fugitive",
        dependencies = { "tpope/vim-rhubarb" },
        config = function()
            -- When I autcomlete :gbrowse it defaults to this version, and this version just
            -- prints a deprecation warning... so this helps make sure that stops happening.
            vim.api.nvim_del_user_command("Gbrowse")
        end,
    },
}
