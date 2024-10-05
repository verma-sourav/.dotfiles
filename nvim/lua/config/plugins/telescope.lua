local M = {
   "nvim-telescope/telescope.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "debugloop/telescope-undo.nvim",
   },
}

M.config = function()
   local telescope = require("telescope")
   local actions = require("telescope.actions")
   local open_with_trouble = require("trouble.sources.telescope").open
   local add_to_trouble = require("trouble.sources.telescope").add
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
         mappings = {
            i = { ["<C-t>"] = open_with_trouble, ["<M-t>"] = add_to_trouble },
            n = { ["<C-t>"] = open_with_trouble, ["<M-t>"] = add_to_trouble },
         },
         layout_strategy = "vertical",
         layout_config = {
            vertical = {
               height = 0.9,
               width = 0.8,
               prompt_position = "bottom",
               preview_height = 0.4,
            },
         },
      },
      pickers = {
         lsp_document_symbols = {
            symbol_width = 70,
         },
         buffers = {
            theme = "ivy",
            scroll_strategy = "limit",
            mappings = {
               n = {
                  ["d"] = actions.delete_buffer,
               },
            },
         },
      },
   })
   telescope.load_extension("fzy_native")
   telescope.load_extension("undo")
end

-- Cache the result of `git rev-parse`
local is_inside_work_tree = {}
M.project_files = function()
   local cwd = vim.fn.getcwd()
   if is_inside_work_tree[cwd] == nil then
      vim.fn.system("git rev-parse --is-inside-work-tree")
      is_inside_work_tree[cwd] = vim.v.shell_error == 0
   end

   if is_inside_work_tree[cwd] then
      require("telescope.builtin").git_files({ show_untracked = true })
   else
      require("telescope.builtin").find_files({})
   end
end

return M
