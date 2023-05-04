local M = {
   "synaptiko/xit.nvim",
   build = function(plugin)
      plugin.config()
      vim.cmd(":TSInstall! xit")
   end,
}

local function get_highlight_by_id(id)
   local result = {}
   local main_highlight = vim.api.nvim_get_hl_by_id(id, true)

   if main_highlight[true] then
      local linked_id = main_highlight[true]
      local linked_highlight = get_highlight_by_id(linked_id)

      for key, value in pairs(linked_highlight) do
         result[key] = value
      end

      main_highlight[true] = nil
   end

   for key, value in pairs(main_highlight) do
      result[key] = value
   end

   return result
end

local function get_highlight_by_name(name)
   return get_highlight_by_id(vim.api.nvim_get_hl_id_by_name(name))
end

function M.config()
   -- The plugin's highlighting is currently broken and the fix PR has been open for a while
   -- without being merged. This manually sets the highlights to match the fix PR.
   -- https://github.com/synaptiko/xit.nvim/pull/6
   require("xit").setup({ disable_default_highlights = false })

   local headlineHighlight = get_highlight_by_name("Normal")
   local openHighlight = get_highlight_by_name("Normal")
   local openCheckboxHighlight = get_highlight_by_name("Normal")
   local ongoingHighlight = get_highlight_by_name("MoreMsg")
   local checkedHighlight = get_highlight_by_name("Comment")
   local obsoleteHighlight = get_highlight_by_name("Comment")
   local obsoleteStrikedHighlight = get_highlight_by_name("Comment")
   local priorityHighlight = get_highlight_by_name("ErrorMsg")
   local inquestionHighlight = get_highlight_by_name("Character")

   headlineHighlight.underline = true
   headlineHighlight.bold = true
   openCheckboxHighlight.bold = true
   openHighlight.bold = nil
   ongoingHighlight.bold = true
   priorityHighlight.bold = true
   checkedHighlight.italic = nil
   checkedHighlight.bold = nil
   obsoleteHighlight.italic = nil
   obsoleteHighlight.bold = nil
   obsoleteStrikedHighlight.italic = nil
   obsoleteStrikedHighlight.strikethrough = true
   inquestionHighlight.strikethrough = nil

   vim.api.nvim_set_hl(0, "@XitHeadline", headlineHighlight)

   vim.api.nvim_set_hl(0, "@XitOpenCheckbox", openCheckboxHighlight)
   vim.api.nvim_set_hl(0, "@XitOpenTaskMainLine", openHighlight)
   vim.api.nvim_set_hl(0, "@XitOpenTaskOtherLine", openHighlight)
   vim.api.nvim_set_hl(0, "@XitOpenTaskPriority", priorityHighlight)

   vim.api.nvim_set_hl(0, "@XitOngoingCheckbox", ongoingHighlight)
   vim.api.nvim_set_hl(0, "@XitOngoingTaskMainLine", ongoingHighlight)
   vim.api.nvim_set_hl(0, "@XitOngoingTaskOtherLine", ongoingHighlight)
   vim.api.nvim_set_hl(0, "@XitOngoingTaskPriority", priorityHighlight)

   vim.api.nvim_set_hl(0, "@XitCheckedCheckbox", checkedHighlight)
   vim.api.nvim_set_hl(0, "@XitCheckedTaskMainLine", checkedHighlight)
   vim.api.nvim_set_hl(0, "@XitCheckedTaskOtherLine", checkedHighlight)
   vim.api.nvim_set_hl(0, "@XitCheckedTaskPriority", checkedHighlight)

   vim.api.nvim_set_hl(0, "@XitObsoleteCheckbox", obsoleteHighlight)
   vim.api.nvim_set_hl(0, "@XitObsoleteTaskMainLine", obsoleteStrikedHighlight)
   vim.api.nvim_set_hl(0, "@XitObsoleteTaskOtherLine", obsoleteStrikedHighlight)
   vim.api.nvim_set_hl(0, "@XitObsoleteTaskPriority", obsoleteStrikedHighlight)

   vim.api.nvim_set_hl(0, "@XitInQuestionCheckbox", inquestionHighlight)
   vim.api.nvim_set_hl(0, "@XitInQuestionTaskMainLine", inquestionHighlight)
   vim.api.nvim_set_hl(0, "@XitInQuestionTaskOtherLine", inquestionHighlight)
   vim.api.nvim_set_hl(0, "@XitInQuestionTaskPriority", inquestionHighlight)
end

return M
