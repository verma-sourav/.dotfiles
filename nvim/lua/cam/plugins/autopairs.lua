local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
  return
end

autopairs.setup({})

-- Insert `(` after selecting a function or method from nvim-cmp
local ap_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if not ap_ok then
  return
end

local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
