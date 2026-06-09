vim.pack.add({
    -- Git
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/tpope/vim-rhubarb",
    -- LSP and Formatting
    "https://github.com/folke/lazydev.nvim",
    -- Utilities
    "https://github.com/folke/trouble.nvim",
    "https://github.com/NMAC427/guess-indent.nvim",
    -- Visual
    "https://github.com/Bekaboo/dropbar.nvim",
    "https://github.com/yorickpeterse/nvim-pqf",
    "https://github.com/catppuccin/nvim",
})

require("guess-indent").setup({})
require("diffview").setup({ use_icons = false })

require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
    },
})

require("trouble").setup({
    auto_preview = false,
    auto_jump = true,
    follow = false,
    indent_guides = true,
})
require("pqf").setup()
require("catppuccin").setup({
    flavour = "mocha",
    integrations = {
        blink_cmp = true,
        diffview = true,
        dropbar = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = { enabled = true, indentscope_color = "" },
        snacks = { enabled = true },
    },
    custom_highlights = function(colors)
        return {
            -- Make borders between windows clearer
            WinSeparator = { fg = colors.flamingo },
        }
    end,
})

vim.cmd("colorscheme catppuccin")
