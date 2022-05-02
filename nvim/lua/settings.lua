local undoDirectory = '/tmp/nvim-undo'

-- Basic Settings
vim.opt.backspace = 'indent,eol,start'  -- Allow backspacing over indentation, line breaks, and insertion start
vim.opt.confirm = true                  -- Show a confirmation dialog when closing an unsaved file
vim.opt.encoding = 'utf-8'              -- Use unicode encoding
vim.opt.mouse = 'a'                     -- Allow the mouse to be used in all modes
vim.opt.errorbells = false              -- No bells
vim.opt.titlestring = '%t'              -- Use the name of the file as the window title
vim.opt.title = true                    -- Apply the titlestring above

-- Display
vim.opt.cursorline = true       -- Highlight the current cursor line
vim.opt.laststatus = 3          -- Always display the status bar
vim.opt.wrap = false            -- Don't wrap text, let it go off screen
vim.opt.number = true           -- Display line numbers
vim.opt.ruler = true            -- Display the current cursor position
vim.opt.scrolloff = 8           -- Keep at least n lines above and below the cursor
vim.opt.sidescrolloff = 5       -- Keep at least n columns to the side of the cursor
vim.opt.showmatch = true        -- Show matching brackets
vim.opt.termguicolors = true    -- Enable 24-bit color

-- Search
vim.opt.incsearch = true    -- Enable incremental searching
vim.opt.ignorecase = true   -- Ignore case in search patterns
vim.opt.smartcase = true    -- If the search has uppercase letters, override ignorecase

-- Whitespace
vim.opt.autoindent = true   -- Automatically indent
vim.opt.expandtab = true    -- Expand tabs to spaces
vim.opt.smartindent = true  -- Smart indentation on new lines (e.g. indentation after brackets)
vim.opt.shiftround = true   -- Round indentation to the nearest multiple of shiftwidth
vim.opt.shiftwidth = 4      -- Indent using n spaces
vim.opt.tabstop = 4         -- 1 tab = n spaces
vim.opt.textwidth = 0       -- Set the width that text is hard wrapped (0 is disabled)

-- Backups
vim.opt.autowrite = true        -- Automatically save files when switching buffers
vim.opt.backup = false          -- Don't create backups when overwriting files
vim.opt.swapfile = false        -- Disable use of a swap file
vim.opt.undofile = true         -- Automatically save undo history to a file
vim.opt.undodir = undoDirectory -- Location to store undo files

-- Ignore
vim.opt.wildignore = {
    'deps','.svn','CVS','.git','.DS_Store', '*.o','*.a','*.class','*.mo','*.la','*.so','*.obj',
    '*.swp', '*.jpg','*.png','*.gif','*.out'
}

-- Make sure the undo directory exists so it can be used by neovim
if vim.fn.isdirectory(undoDirectory) == 0 then
    vim.call('mkdir', undoDirectory, '', 0700)
end

vim.opt.background = 'dark'
vim.cmd('colorscheme gruvbox')
vim.g.lightline = { colorscheme = 'gruvbox' }

-- Allows filetype-specific configs in ~/.config/nvim/after/ftplugin/language.vim
vim.cmd('filetype plugin on')
