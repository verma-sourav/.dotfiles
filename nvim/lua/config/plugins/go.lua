return {
   "crispgm/nvim-go",
   build = ":GoInstallBinaries",
   dependencies = {
      "nvim-lua/plenary.nvim",
   },
   opts = {
      notify = true,
      test_popup_width = 100,
      test_popup_height = 20,
      -- Use LSP configurations to format and lint, not this plugin
      auto_format = false,
      auto_lint = false,
   },
}
