local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

comment.setup({
  ---Add a space b/w comment and the line
  padding = true,

  ---Whether the cursor should stay at its position
  ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
  sticky = true,

  ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  ---NOTE: If `mappings = false` then the plugin won't create any mappings
  mappings = {
    ---Operator-pending mapping
    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,
    ---Extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = true,
    ---Extended mapping
    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },

  ---LHS of toggle mappings in NORMAL + VISUAL mode
  toggler = {
    line = "gcc",
    block = "gbc",
  },

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  opleader = {
    line = "gc",
    block = "gb",
  },

  ---LHS of extra mappings
  extra = {
    ---Add comment on the line above
    above = "gcO",
    ---Add comment on the line below
    below = "gco",
    ---Add comment at the end of line
    eol = "gcA",
  },
})
