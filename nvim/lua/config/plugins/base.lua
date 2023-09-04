local barbecue = {
   "utilyre/barbecue.nvim",
   name = "barbecue",
   dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
   },
   config = function()
      require("barbecue").setup()
   end,
}

local catppuccin = {
   "catppuccin/nvim",
   config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup()
      vim.cmd("colorscheme catppuccin")
   end,
}

local dressing = {
   "stevearc/dressing.nvim",
   config = function()
      require("dressing").setup()
   end,
}

local gitsigns = {
   "lewis6991/gitsigns.nvim",
   config = function()
      require("gitsigns").setup()
   end,
}

local lualine = {
   "nvim-lualine/lualine.nvim",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   config = function()
      require("lualine").setup()
   end,
}

local mini = {
   "echasnovski/mini.nvim",
   version = "*",
   config = function()
      local function enable_module(module, opts)
         require("mini." .. module).setup(opts)
      end
      -- https://github.com/echasnovski/mini.nvim
      enable_module("comment")
      enable_module("move")
      enable_module("pairs")
      enable_module("trailspace")
   end,
}

return {
   barbecue,
   catppuccin,
   dressing,
   gitsigns,
   lualine,
   mini,
}
