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

Plug 'nvim-telescope/telescope.nvim'            -- Highly extensible fuzzy finder
Plug 'nvim-telescope/telescope-fzy-native.nvim' -- Native sorter to speed up telescope
Plug 'itchyny/lightline.vim'                    -- Configurable statusline/tabline plugin
Plug 'lewis6991/gitsigns.nvim'                  -- Git decorations in buffer sidebars
Plug 'karb94/neoscroll.nvim'                    -- Smooth scrolling
Plug 'nvim-lua/plenary.nvim'                    -- Lua library used by a lot of plugins

-- Colorschemes
Plug ('folke/tokyonight.nvim', {branch = 'main'})

-- LSP & Parsers
Plug 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client

-- Treesitter (abstraction layer for tree-sitter parser)
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

require('gitsigns').setup()
require('neoscroll').setup()
require('telescope').load_extension('fzy_native')
