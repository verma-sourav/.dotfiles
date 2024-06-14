local barbecue = {
   "utilyre/barbecue.nvim",
   name = "barbecue",
   dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
   },
   opts = {},
}

local bufferline = {
   "akinsho/bufferline.nvim",
   event = "VeryLazy",
   config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
         options = {
            close_command = function(n)
               require("mini.bufremove").delete(n, false)
            end,
            right_mouse_command = function(n)
               require("mini.bufremove").delete(n, false)
            end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            style_preset = bufferline.style_preset.minimal,
            show_buffer_icons = false,
            offsets = {
               {
                  filetype = "neo-tree",
                  text = "Explorer",
                  highlight = "Directory",
                  text_align = "left",
               },
            },
         },
      })
   end,
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

local floating_help = {
   "nil70n/floating-help",
   opts = {
      border = "rounded",
   },
}

local notify = {
   "rcarriga/nvim-notify",
   config = function()
      vim.notify = require("notify")
   end,
}

return {
   barbecue,
   bufferline,
   catppuccin,
   dressing,
   floating_help,
   notify,
}
