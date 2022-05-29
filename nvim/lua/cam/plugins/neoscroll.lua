--[[
Looks like smooth scrolling with the mouse is being looked at
  https://github.com/karb94/neoscroll.nvim/issues/50
Would like to potentially add smooth scolling to { and }
  https://github.com/karb94/neoscroll.nvim/issues/55
--]]

local ok, neoscroll = pcall(require, 'neoscroll')
if not ok then
  return
end

neoscroll.setup()
