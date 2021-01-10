" Welcome to vimrc
" -- Vim Settings
syntax on

set noerrorbells
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set colorcolumn=80,100
set noshowmode " With the lightline plugin, the -- INSERT -- display is redundant

" -- Plugin Manager & Plugins
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
Plug 'phanviet/vim-monokai-pro'
Plug 'sainnhe/gruvbox-material'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'       " Git Integration
Plug 'jremmen/vim-ripgrep'      " Fast searching
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'          " Visual tree for undos/changes
Plug 'tweekmonster/gofmt.vim'   " Runs gofmt on save
Plug 'sheerun/vim-polyglot'     " Language pack support - better highlighting, indentation, etc
Plug 'preservim/nerdtree'       " Directory/file tree viewer
call plug#end()

" ripgrep
if executable('rg')
    let g:rg_derive_root='true'
endif

" fzf
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}

" nerdtree
let g:netrw_winsize = 20

" lightline
set laststatus=2
let g:lightline = {'colorscheme': 'monokai_pro'}

" -- Scheme Changes
colorscheme monokai_pro

" -- Mappings
let mapleader = " "


