local barbecue = {
   "utilyre/barbecue.nvim",
   name = "barbecue",
   dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
   },
   opts = {},
}

local catppuccin = {
   "catppuccin/nvim",
   config = function()
      require("catppuccin").setup({
         flavour = "mocha",
         integrations = {
            -- Some integrations are disabled by default, so they are being enabled here
            mason = true,
            mini = {
               enabled = true,
               indentscope_color = "",
            },
         },
      })
      vim.cmd("colorscheme catppuccin")
   end,
}

local dressing = {
   "stevearc/dressing.nvim",
   opts = {},
}

return {
   barbecue,
   catppuccin,
   dressing,
}
