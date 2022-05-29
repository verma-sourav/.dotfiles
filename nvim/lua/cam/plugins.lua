local install_path = vim.fn.stdpath('data') .. '/site/plugged'
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

vim.call('plug#begin', install_path)

-- Colorschemes and style plugins
Plug ('folke/tokyonight.nvim', {branch = 'main'})
Plug 'itchyny/lightline.vim'

-- File Explorer
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'cappyzawa/trim.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'rcarriga/nvim-notify'
Plug 'lewis6991/gitsigns.nvim'
Plug 'karb94/neoscroll.nvim'

-- Snippets and Completion
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind.nvim'

-- Language Server & Parsing
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

-- Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

-- Common Dependencies
Plug 'nvim-lua/plenary.nvim'

vim.call('plug#end')

local config_files = {
  'autopairs',
  'cmp',
  'colorscheme',
  'comment',
  'gitsigns',
  'lsp',
  'neoscroll',
  'notify',
  'nvim-tree',
  'telescope',
  'treesitter',
  'trim'
}

for _, file in pairs(config_files) do
  require('cam.plugins.' .. file)
end
