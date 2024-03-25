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
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
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

local floating_help = {
   "nil70n/floating-help",
   opts = {
      border = "rounded",
   },
}

local dressing = {
   "stevearc/dressing.nvim",
   opts = {},
}

local gitlinker = {
   "linrongbin16/gitlinker.nvim",
   opts = {},
}

local gitsigns = {
   "lewis6991/gitsigns.nvim",
   opts = {},
}

local harpoon = {
   "ThePrimeagen/harpoon",
   branch = "harpoon2",
   dependencies = { "nvim-lua/plenary.nvim" },
   config = function()
      local harpoon = require("harpoon")

      harpoon:setup()
      vim.keymap.set(
         "n",
         "<leader>a",
         function() harpoon:list():append() end,
         { desc = "harpoon: append file to list" }
      )
      vim.keymap.set(
         "n",
         "<C-e>",
         function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
         { desc = "harpoon: open quick menu" }
      )
   end,
}

local lualine = {
   "nvim-lualine/lualine.nvim",
   dependencies = {
      "nvim-tree/nvim-web-devicons",
   },
   opts = {},
}

local mini = {
   "echasnovski/mini.nvim",
   version = "*",
   config = function()
      local function enable_module(module, opts) require("mini." .. module).setup(opts) end
      enable_module("bufremove")
      enable_module("comment")
      enable_module("indentscope")
      enable_module("move")
      enable_module("trailspace")
      enable_module("pairs")
   end,
}

local neotree = {
   "nvim-neo-tree/neo-tree.nvim",
   branch = "v3.x",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
   },
   opts = {
      sort_case_insensitive = true,
      use_libuv_file_watcher = true,
      window = { position = "right" },
      follow_current_file = { enabled = true },
      sources = {
         "filesystem",
         "buffers",
         "git_status",
         "document_symbols",
      },
   },
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
            c = {
               name = "code",
               g = { name = "goto" },
            },
            f = { name = "files" },
            g = {
               name = "git",
               b = { name = "buffer" },
               h = { name = "hunk" },
               l = { name = "line" },
            },
            s = { name = "search" },
            t = { name = "toggle" },
            x = { name = "errors/diagnostics" },
         },
      })
   end,
}

return {
   barbecue,
   bufferline,
   catppuccin,
   dressing,
   floating_help,
   gitlinker,
   gitsigns,
   harpoon,
   lualine,
   mini,
   neotree,
   telescope,
   which_key,
}
