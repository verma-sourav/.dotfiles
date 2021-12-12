source ~/.config/nvim/plugins.vim
source ~/.config/nvim/keybinds.vim
source ~/.config/nvim/styles.vim

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
set termguicolors               " Enable 24-bit color
set undofile                    " Automatically save undo history to an undo file
set undodir='/tmp/nvim-undo'

if !isdirectory('/tmp/nvim-undo')
    call mkdir('/tmp/nvim-undo', '', 0700)
endif

set formatoptions-=cro          " Don't automatically format text
autocmd FileType * set formatoptions-=cro

" Spell-check Markdown files and Git Commit Messages
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

" Allows filetype-specific configs in ~/.config/nvim/after/ftplugin/language.vim
filetype plugin on

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 200})
augroup END
