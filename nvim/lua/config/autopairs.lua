require("nvim-autopairs").setup({
  -- Ignore alphanumeric and `.` symbol
  ignored_next_char = "[%w%.]",
  check_ts = true,
})

-- Insert `(` after selecting a function or method from nvim-cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
