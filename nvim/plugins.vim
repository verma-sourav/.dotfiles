" Automatically install plug if it is missing
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Automatically run PlugInstall if there are any missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.local/share/nvim/site/plugged')

" Themes and styles
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'itchyny/lightline.vim'

" Language server and parsing 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

" Code navigation improvements
Plug 'lewis6991/gitsigns.nvim'             
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }      
Plug 'ray-x/navigator.lua'                 
Plug 'simrat39/symbols-outline.nvim'      
Plug 'karb94/neoscroll.nvim'

" Telescope (fuzzy finder) and dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" One day I will make neovim work for me and Go
Plug 'ray-x/go.nvim'

call plug#end()

lua <<EOF
require('navigator').setup()
require('gitsigns').setup()
require('neoscroll').setup()
EOF

