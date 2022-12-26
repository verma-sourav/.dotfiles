local M = {
   "nvim-neo-tree/neo-tree.nvim",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
   },
}

function M.config()
   vim.cmd("let g:neo_tree_remove_legacy_commands = 1")
   require("neo-tree").setup({
      filesystem = {
         filtered_items = {
            -- When true, they will be displayed differently than normal items
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {},
            hide_by_pattern = {},
            always_show = {
               ".gitignore",
            },
            never_show = {
               ".DS_Store",
            },
            never_show_by_pattern = {
               "**/.git",
               "**/node_modules",
               "**/*.o",
            },
         },
         follow_current_file = true,
         group_empty_dirs = true,
      },
   })
end

return M
