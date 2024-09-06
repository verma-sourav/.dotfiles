local detail = false
return {
   "stevearc/oil.nvim",
   opts = {
      delete_to_trash = true,
      lsp_file_methods = {
         autosave_changes = true,
      },
      keymaps = {
         ["q"] = "actions.close",
         ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
               detail = not detail
               if detail then
                  require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
               else
                  require("oil").set_columns({ "icon" })
               end
            end,
         },
      },
   },
}
