local M = {
   "folke/which-key.nvim",
}

function M.config()
   local util = require("util")
   local wk = require("which-key")

   -- which-key determines when to display using the timeoutlen setting
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

   -- Faster buffer navigation
   util.nnoremap("<C-h>", "<C-w>h")
   util.nnoremap("<C-j>", "<C-w>j")
   util.nnoremap("<C-k>", "<C-w>k")
   util.nnoremap("<C-l>", "<C-w>l")

   -- Resize window using shift + arrow keys
   util.nnoremap("<S-Up>", ":resize +2<CR>")
   util.nnoremap("<S-Down>", ":resize -2<CR>")
   util.nnoremap("<S-Left>", ":vertical resize -2<CR>")
   util.nnoremap("<S-Right>", ":vertical resize +2<CR>")

   -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
   util.nnoremap("n", "'Nn'[v:searchforward]", { expr = true })
   util.xnoremap("n", "'Nn'[v:searchforward]", { expr = true })
   util.onoremap("n", "'Nn'[v:searchforward]", { expr = true })
   util.nnoremap("N", "'nN'[v:searchforward]", { expr = true })
   util.xnoremap("N", "'nN'[v:searchforward]", { expr = true })
   util.onoremap("N", "'nN'[v:searchforward]", { expr = true })

   -- https://github.com/mhinz/vim-galore#dont-lose-selection-when-shifting-sidewards
   util.xnoremap(">", ">gv")
   util.xnoremap("<", "<gv")

   local leader = {
      ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
      [","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
      b = {
         name = "+buffer",
         ["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
         ["d"] = { "<cmd>:Bdelete<CR>", "Delete Buffer" },
      },
      f = {
         name = "+file",
         r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
         n = { "<cmd>enew<cr>", "New File" },
      },
      g = {
         name = "+git",
         c = { "<cmd>Telescope git_commits<CR>", "Commits" },
         C = { "<cmd>Telescope git_bcommits<CR>", "Buffer Commits" },
         b = { "<cmd>Telescope git_branches<CR>", "Branches" },
         d = { "<cmd>DiffviewToggle<CR>", "Diffview" },
         s = { "<cmd>Telescope git_status<CR>", "Status" },
         S = { "<cmd>Telescope git_stash<CR>", "Stashes" },
      },
      h = {
         name = "+help",
         t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
         c = { "<cmd>:Telescope commands<cr>", "Commands" },
         h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
         m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
         k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
         s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
         f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
         o = { "<cmd>:Telescope vim_options<cr>", "Options" },
         a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
      },
      q = {
         name = "+quit/session",
         q = { "<cmd>:qa<cr>", "Quit" },
         ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
      },
      s = {
         name = "+search",
         r = { "<cmd>Telescope resume<cr>", "Resume" },
         f = { "<cmd>Telescope find_files<cr>", "Find File" },
         g = { "<cmd>Telescope live_grep<cr>", "Grep" },
         b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
         s = {
            function()
               require("telescope.builtin").lsp_document_symbols({
                  symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait" },
               })
            end,
            "Symbols",
         },
         h = { "<cmd>Telescope command_history<cr>", "Command History" },
         m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
      },
      t = {
         name = "toggle",
         f = { "<cmd>NeoTreeShowToggle<cr>", "File Tree" },
         n = {
            function()
               util.toggle("number")
            end,
            "Line Numbers",
         },
         r = {
            function()
               util.toggle("relativenumber")
            end,
            "Relative Line Numbers",
         },
         s = {
            function()
               util.toggle("spell")
            end,
            "Spelling",
         },
         w = {
            function()
               util.toggle("wrap")
            end,
            "Word Wrap",
         },
      },
      x = {
         name = "+errors",
         f = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open Diagnostics Float" },
         t = { "<cmd>Telescope diagnostics<cr>", "Telescope Diagnostics" },
      },
   }

   wk.register(leader, { prefix = "<leader>" })
end

return M
