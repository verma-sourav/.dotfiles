local M = {
   "echasnovski/mini.nvim",
   version = false,
}

local function enable_module(module, opts)
   require("mini." .. module).setup(opts)
end

function M.config()
   -- https://github.com/echasnovski/mini.nvim
   enable_module("animate", {
      -- scroll animations are currently acting weird with scrolloff set
      -- https://github.com/echasnovski/mini.nvim/issues/294
      scroll = { enable = false },
   })
   enable_module("comment")
   enable_module("move")
   enable_module("jump")
   enable_module("pairs")
   enable_module("trailspace")
end

return M
