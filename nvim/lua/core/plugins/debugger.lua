return {
    { "mfussenegger/nvim-dap" },
    { "leoluz/nvim-dap-go", opts = {} },
    {
        "igorlfs/nvim-dap-view",
        opts = {
            auto_toggle = true,
            winbar = {
                sections = { "console", "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
                controls = {
                    enabled = true,
                    position = "right",
                },
            },
        },
    },
}
