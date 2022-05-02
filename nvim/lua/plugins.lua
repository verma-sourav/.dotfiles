local pluginDirectory = '~/.local/share/nvim/site/plugged'
local Plug = vim.fn['plug#']

-- https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
-- Install vim-plug if it is not already installed
vim.cmd([[
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]])

-- Automatically install any missing plugins
vim.cmd([[
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
\| endif
]])

vim.call('plug#begin', pluginDirectory)

-- Theme and style improvements
Plug ('folke/tokyonight.nvim', {branch = 'main'})
Plug 'itchyny/lightline.vim'

-- Language server and parsing
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'neovim/nvim-lspconfig'

-- Code navigation improvements
Plug 'lewis6991/gitsigns.nvim'
Plug 'karb94/neoscroll.nvim'

-- Telescope (fuzzy finder) and dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

vim.call('plug#end')

require('gitsigns').setup()
require('neoscroll').setup()
