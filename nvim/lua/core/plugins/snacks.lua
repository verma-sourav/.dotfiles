local M = {
   "folke/snacks.nvim",
   priority = 1000,
   lazy = false,
   opts = {
      bigfile = { enabled = true },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      indent = {
         enabled = true,
         -- https://github.com/folke/snacks.nvim/discussions/332
         indent = { enabled = false },
      },
      formatters = {
         file = {
            truncate = 100,
         },
      },
      picker = {
         enabled = true,
         layouts = {
            fullscreen = {
               fullscreen = true,
               layout = {
                  backdrop = false,
                  box = "vertical",
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                  { win = "input", height = 1, border = "bottom" },
                  { win = "list", border = "none" },
                  { win = "preview", title = "{preview}", height = 0.5, border = "top" },
               },
            },
         },
         layout = function(source)
            if vim.endswith(source, "files") then return "fullscreen" end
            if source == "grep" then return "fullscreen" end
            return vim.o.columns >= 120 and "default" or "vertical"
         end,
      },
      statuscolumn = { enabled = true },
   },
}

-- Cache the result of `git rev-parse`
local is_inside_work_tree = {}

-- Show git files when in a repository, otherwise just show all files.
-- Ideally this should be moved to a custom picker, but I haven't figured out how to do that yet.
function M.project_files()
   local cwd = vim.fn.getcwd()
   if is_inside_work_tree[cwd] == nil then
      vim.fn.system("git rev-parse --is-inside-work-tree")
      is_inside_work_tree[cwd] = vim.v.shell_error == 0
   end

   if is_inside_work_tree[cwd] then
      Snacks.picker.git_files({ untracked = true })
   else
      Snacks.picker.files()
   end
end

return M
