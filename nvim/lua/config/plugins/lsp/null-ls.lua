local nls = require("null-ls")
local util = require("util")

local M = {}

function M.setup(options)
   local sources = {
      nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
      nls.builtins.formatting.goimports,
      nls.builtins.formatting.stylua,
   }

   if util.executable("clang-format-10") then
      table.insert(sources, nls.builtins.formatting.clang_format.with({ command = "clang-format-10" }))
   end

   nls.setup({
      on_attach = options.on_attach,
      sources = sources,
   })
end

return M
