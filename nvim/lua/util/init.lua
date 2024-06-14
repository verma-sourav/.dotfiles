local M = {}

function M.toggle(option, silent)
   local info = vim.api.nvim_get_option_info(option)
   local scopes = { buf = "bo", win = "wo", global = "o" }
   local scope = scopes[info.scope]
   local options = vim[scope]
   options[option] = not options[option]
   if silent ~= true then
      if options[option] then
         M.info("enabled vim." .. scope .. "." .. option, "Toggle")
      else
         M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
      end
   end
end

function M.executable(command)
   return vim.fn.executable(command) == 1
end

function M.merge_tables(base, addl)
   return vim.tbl_deep_extend("force", {}, base, addl or {})
end

function M.use_tabs_local(tabstop)
   tabstop = tabstop or 4
   vim.opt_local.expandtab = false
   vim.opt_local.tabstop = tabstop
   vim.opt_local.shiftwidth = tabstop
end

function M.use_spaces_local(num_spaces)
   num_spaces = num_spaces or 4
   vim.opt_local.expandtab = true
   vim.opt_local.tabstop = num_spaces
   vim.opt_local.shiftwidth = num_spaces
end

function M.glob(pattern)
   return vim.fn.split(vim.fn.glob(pattern), "\n")
end

return M
