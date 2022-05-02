local function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

map('', '<Space>', '<Nop>')
vim.g.mapleader = ' '

-- Normal --
local function nmap(shortcut, command)
    map('n', shortcut, command)
end

-- Faster buffer navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Resize with arrows
nmap('<C-Up>', ':resize -2<CR>')
nmap('<C-Down>', ':resize +2<CR>')
nmap('<C-Left>', ':vertical resize -2<CR>')
nmap('<C-Right>', ':vertical resize +2<CR>')

-- Navigate buffers
nmap('<S-l>', ':bnext<CR>')
nmap('<S-h>', ':bprevious<CR>')

-- Move text up and down
nmap('<A-j>', '<Esc>:m .+1<CR>==gi')
nmap('<A-k>', '<Esc>:m .-2<CR>==gi')

-- Telescope mappings
nmap('<leader>ff', '<cmd>Telescope find_files<cr>')
nmap('<leader>fg', '<cmd>Telescope live_grep<cr>')
nmap('<leader>fb', '<cmd>Telescope live_grep<cr>')
nmap('<leader>fh', '<cmd>Telescope live_grep<cr>')

-- Visual --
local function vmap(shortcut, command)
    map('v', shortcut, command)
end

-- Stay in indent mode
vmap('<', '<gv')
vmap('>', '>gv')

-- Move text up and down
vmap('<A-j>', ':m .+1<CR>==')
vmap('<A-k>', ':m .-2<CR>==')

-- After replacing text with pasted text, don't replace what text is copied.
vmap('p', '"_dP')

-- Visual Block --
local function xmap(shortcut, command)
    map('x', shortcut, command)
end

-- Move text up and down
xmap('J', ":move '>+1<CR>gv-gv")
xmap('K', ":move '<-2<CR>gv-gv")
xmap('<A-j>', ":move '>+1<CR>gv-gv")
xmap('<A-k>', ":move '<-2<CR>gv-gv")
