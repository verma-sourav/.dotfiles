-- Automatically install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
  vim.cmd('packadd packer.nvim')
end

local groupPacker = vim.api.nvim_create_augroup('packer_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = groupPacker,
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerSync',
  desc = 'Automatically reload neovim when you save the plugins.lua file'
})

local function packer_startup(use)
  use 'wbthomason/packer.nvim'

  -- Display
  use 'folke/tokyonight.nvim'
  use 'itchyny/lightline.vim'
  use 'rcarriga/nvim-notify'
  use 'lewis6991/gitsigns.nvim'
  use 'karb94/neoscroll.nvim'
  use 'onsails/lspkind.nvim'
  use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}

  -- Misc
  use 'cappyzawa/trim.nvim'
  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- Language Server & Parsing
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-fzy-native.nvim'
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end

local packer = require('packer')

packer.init({
  display = {
    open_fn = function() return require('packer.util').float { border = 'rounded' } end
  }
})

return packer.startup(packer_startup)
