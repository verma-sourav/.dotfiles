local barbecue = {
   "utilyre/barbecue.nvim",
   name = "barbecue",
   dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
   },
   config = function() require("barbecue").setup() end,
}

local catppuccin = {
   "catppuccin/nvim",
   config = function()
      vim.g.catppuccin_flavour = "mocha"
      require("catppuccin").setup({
         integrations = {
            -- Some integrations are disabled by default, so they are being enabled here
            mason = true,
            which_key = true,
         },
      })
      vim.cmd("colorscheme catppuccin")
   end,
}

local dressing = {
   "stevearc/dressing.nvim",
   config = function() require("dressing").setup() end,
}

local gitsigns = {
   "lewis6991/gitsigns.nvim",
   config = function() require("gitsigns").setup() end,
}

local lualine = {
   "nvim-lualine/lualine.nvim",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   config = function() require("lualine").setup() end,
}

local mini = {
   "echasnovski/mini.nvim",
   version = "*",
   config = function()
      local function enable_module(module, opts) require("mini." .. module).setup(opts) end

      enable_module("comment")
      enable_module("indentscope")
      enable_module("move")
      enable_module("trailspace")
      enable_module("pairs")
   end,
}

local oil = {
   "stevearc/oil.nvim",
   opts = {},
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   config = function()
      require("oil").setup({
         delete_to_trash = true,
         lsp_rename_autosave = true,
      })
   end,
}

local telescope = {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "debugloop/telescope-undo.nvim",
   },
   config = function()
      local telescope = require("telescope")
      telescope.setup({
         defaults = {
            vimgrep_arguments = {
               "rg",
               "--color=never",
               "--no-heading",
               "--with-filename",
               "--line-number",
               "--column",
               "--smart-case",
            },
         },
      })
      telescope.load_extension("fzy_native")
      telescope.load_extension("undo")
   end,
}

local toggleterm = {
   "akinsho/toggleterm.nvim",
   version = "*",
   config = function() require("toggleterm").setup() end,
}

local which_key = {
   "folke/which-key.nvim",
   config = function()
      local wk = require("which-key")
      -- The timeoutlen setting is used to determine when to show the binding popup
      vim.o.timeout = true
      vim.o.timeoutlen = 300

      wk.setup({
         key_labels = { ["<leader>"] = "SPC" },
         plugins = {
            spelling = {
               enabled = true,
               suggestions = 20,
            },
         },
      })

      -- I'm only going to register the group names in which-key. I don't want to register the maps
      -- themselves in which-key because I find the heavily-indented table hard to read and it makes
      -- it difficult to remove which-key in the future.
      wk.register({
         ["<leader>"] = {
            b = { name = "buffer" },
            c = { name = "code", g = { name = "goto" } },
            f = { name = "files" },
            g = { name = "git" },
            s = { name = "search" },
            t = { name = "toggle" },
            x = { name = "errors/diagnostics" },
         },
      })
   end,
}

return {
   barbecue,
   catppuccin,
   dressing,
   gitsigns,
   lualine,
   mini,
   oil,
   telescope,
   toggleterm,
   which_key,
}
