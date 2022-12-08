local M = {
   "kyazdani42/nvim-tree.lua",
   dependencies = {
      "kyazdani42/nvim-web-devicons",
   },
}

function M.config()
   require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,
      renderer = {
         add_trailing = false,
         group_empty = true,
         highlight_git = true,
         indent_markers = {
            enable = true,
         },
      },
      actions = {
         open_file = {
            resize_window = true,
         },
      },
   })
end

return M
