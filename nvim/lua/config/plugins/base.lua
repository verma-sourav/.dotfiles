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

local noice = {
   "folke/noice.nvim",
   event = "VeryLazy",
   dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
   },
   config = function()
      -- Suggested setup from the README
      require("noice").setup({
         lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
               ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
               ["vim.lsp.util.stylize_markdown"] = true,
               ["cmp.entry.get_documentation"] = true,
            },
         },
         -- you can enable a preset for easier configuration
         presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
         },
      })
   end,
}

local trouble = {
   "folke/trouble.nvim",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   config = function()
      require("trouble").setup()
   end,
}

return {
   barbecue,
   catppuccin,
   dressing,
   gitsigns,
   lualine,
   mini,
   noice,
   trouble,
}
