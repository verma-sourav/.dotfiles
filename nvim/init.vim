" ----- Plugin Management -----------------------------------------------------
" Automatically install plug for neovim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Automatically install missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.local/share/nvim/site/plugged')
" Language Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'mattn/vim-goimports'

" Addon Plugins
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Scheme Plugins
Plug 'patstockwell/vim-monokai-tasty'
call plug#end()

" ----- Vim Settings ----------------------------------------------------------
syntax on
set nohlsearch                  " No search highlighting
set incsearch                   " Incremental searching
set ignorecase                  " Ignore case in search patterns
set smartcase                   " Override ignorecase if the search pattern contains uppercase letters
set autowrite                   " Automatically save files when switching buffers
set autoindent                  " Automatically indent
set smartindent                 " Smart indenting on new lines, i.e. indentation after brackets, etc
set expandtab                   " Convert tabs to spaces
set shiftround                  " When shifting lines, round the indentation to the nearest multiple of shiftwidth
set shiftwidth=4                " Indent using n spaces
set tabstop=4                   " Indent using n spaces
set number                      " Display line numbers
set titlestring=%t              " Show the name of the file as the window title
set title                       " Apply the above titlestring
set ruler                       " Display the current cursor position
set encoding=utf-8              " Use unicode encoding
set nowrap                      " Dont wrap text, let it go off screen
set textwidth=0                 " Disable buffer text breaking/hard wrapping
set scrolloff=8                 " Keep at least n lines above and below the cursor
set sidescrolloff=5             " Keep at least n columns left and right of the cursor
set laststatus=2                " Always display the status bar
set wildmenu                    " Display command line's tab complete options as a menu
set cursorline                  " Highlight the current cursor line
set noerrorbells                " No beeps
set mouse=a                     " Enable mouse for scrolling and resizing
set backspace=indent,eol,start  " Allow backspacing over indentation, line breaks, and insertion start
set confirm                     " Show a confirmation dialog when closing an unsaved file
set noswapfile                  " Disable swap file
set nobackup                    " Dont create backups when overwriting files
set undofile                    " Automatically save undo history to an undo file
set undodir=~/.config/nvim/undo " Directory to store undo files
set termguicolors               " Enable 24-bit color
set signcolumn=yes              " Display the sign column on the left bar (used for errors and stuff)
set colorcolumn=80,100          " Show colored bar ruler at n cols

set formatoptions-=cro          " Don't automatically format text
autocmd FileType * set formatoptions-=cro

" Allows filetype-specific configs in ~/.config/nvim/after/ftplugin/language.vim
filetype plugin on

" ----- Lets ------------------------------------------------------------------
" Netrw
let g:netrw_liststyle=3         " Set list style to tree
let g:netrw_banner=0            " Remove the banner
let g:netrw_winsize=25          " Set the width to 25% of the window


" ----- Colors/Color Scheme ---------------------------------------------------
set background=dark
colorscheme vim-monokai-tasty

" ----- Keymaps ---------------------------------------------------------------
let mapleader = "\<Space>"

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map F5 to open undotree
nnoremap <F5> :UndotreeToggle<CR>

" ----- Language Server -------------------------------------------------------
" set completeopt=menuone,noinsert,noselect
" let g:completion_matching_strategy_list = ['exact','substring', 'fuzzy']
" :lua require("language-servers")
