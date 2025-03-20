local M = {
   "echasnovski/mini.nvim",
   version = false,
   -- statusline stores functions for configuring mini.statusline
   statusline = {},
}

function M.enable_module(module, opts) require("mini." .. module).setup(opts) end

function M.config()
   M.enable_module("bracketed")
   M.enable_module("bufremove")
   M.enable_module("comment")
   M.enable_module("diff")
   M.enable_module("git")
   M.enable_module("jump")
   M.enable_module("move")
   M.enable_module("splitjoin")
   M.enable_module("surround")

   M.enable_trailspace()
   M.enable_clue()
   M.enable_statusline()
end

function M.enable_trailspace()
   M.enable_module("trailspace")
   -- Setup the color for the highlighted trailing whitespace
   vim.api.nvim_set_hl(0, "MiniTrailspace", { bg = "#f38ba8" })
   -- Automatically trim newlines on save
   local trailspace_group = vim.api.nvim_create_augroup("trailspace", { clear = true })
   vim.api.nvim_create_autocmd("BufWritePre", {
      group = trailspace_group,
      desc = "Trim trailing newlines on save",
      pattern = "*",
      command = "silent! lua MiniTrailspace.trim_last_lines()",
   })
end

function M.enable_clue()
   local miniclue = require("mini.clue")
   M.enable_module("clue", {
      triggers = {
         -- Leader triggers
         { mode = "n", keys = "<Leader>" },
         { mode = "x", keys = "<Leader>" },
         -- Built-in completion
         { mode = "i", keys = "<C-x>" },
         -- `g` key
         { mode = "n", keys = "g" },
         { mode = "x", keys = "g" },
         -- Marks
         { mode = "n", keys = "'" },
         { mode = "n", keys = "`" },
         { mode = "x", keys = "'" },
         { mode = "x", keys = "`" },
         -- Registers
         { mode = "n", keys = '"' },
         { mode = "x", keys = '"' },
         { mode = "i", keys = "<C-r>" },
         { mode = "c", keys = "<C-r>" },
         -- Window commands
         { mode = "n", keys = "<C-w>" },
         -- `z` key
         { mode = "n", keys = "z" },
         { mode = "x", keys = "z" },
      },

      window = {
         delay = 750,
         config = { width = "auto" },
      },

      clues = {
         miniclue.gen_clues.builtin_completion(),
         miniclue.gen_clues.g(),
         miniclue.gen_clues.marks(),
         miniclue.gen_clues.registers(),
         miniclue.gen_clues.windows(),
         miniclue.gen_clues.z(),
         { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
         { mode = "n", keys = "<Leader>f", desc = "+Files" },
         { mode = "n", keys = "<Leader>g", desc = "+Git" },
         { mode = "n", keys = "<Leader>s", desc = "+Search" },
         { mode = "n", keys = "<Leader>x", desc = "+Diagnostics" },
         { mode = "n", keys = "<Leader>c", desc = "+Code/LSP" },
         { mode = "n", keys = "<Leader>cg", desc = "+Goto" },
         { mode = "n", keys = "<Leader>cs", desc = "+Show" },
      },
   })
end

function M.enable_statusline()
   -- In the Git summary, just use the branch name and not the rest. This summary is used in the
   -- Git section of the statusline.
   vim.api.nvim_create_autocmd("User", {
      pattern = "MiniGitUpdated",
      callback = function(data)
         local summary = vim.b[data.buf].minigit_summary
         vim.b[data.buf].minigit_summary_string = summary.head_name or ""
      end,
   })

   M.enable_module("statusline", {
      set_vim_settings = false,
      content = {
         active = M.statusline.active_content,
      },
   })
end

function M.statusline.mini() return require("mini.statusline") end

-- Initially on mini's default statusline
-- https://github.com/echasnovski/mini.statusline/blob/94d5e48415bdf872536e5812475fcf19e09f5c0e/lua/mini/statusline.lua#L609
-- stylua: ignore
function M.statusline.active_content()
   local mini           = M.statusline.mini()
   local mode, mode_hl  = mini.section_mode({ trunc_width = 120 })
   local git            = mini.section_git({ trunc_width = 40 })
   local diagnostics    = mini.section_diagnostics({ trunc_width = 75 })
   local filename       = mini.section_filename({ trunc_width = 140 })
   local fileinfo       = M.statusline.section_fileinfo()
   local location       = M.statusline.section_location()

   return mini.combine_groups({
      { hl = mode_hl,                  strings = { string.upper(mode) } },
      { hl = "MiniStatuslineDevinfo",  strings = { git, diagnostics } },
      "%<", -- Mark general truncate point
      { hl = "MiniStatuslineFilename", strings = { filename } },
      "%=", -- End left alignment
      { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
      { hl = mode_hl,                  strings = { location } },
   })
end

-- https://github.com/echasnovski/mini.statusline/blob/94d5e48415bdf872536e5812475fcf19e09f5c0e/lua/mini/statusline.lua#L401
function M.statusline.section_fileinfo()
   local filetype = vim.bo.filetype

   -- Don't show anything if no filetype or not inside a "normal buffer"
   if filetype == "" or vim.bo.buftype ~= "" then return "" end

   return filetype
end

function M.statusline.section_location() return "L%l C%v" end

return M
