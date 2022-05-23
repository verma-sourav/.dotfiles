-- Automatically install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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

  use 'itchyny/lightline.vim'
  use {
    'folke/tokyonight.nvim',
    after = 'lightline.vim',
    config = "require('plugin.colorscheme')"
  }

  use { 'rcarriga/nvim-notify', config = "require('plugin.notify')" }
  use { 'lewis6991/gitsigns.nvim', config = "require('plugin.gitsigns')" }
  use { 'karb94/neoscroll.nvim', config = "require('plugin.neoscroll')" }
  use {
    'kyazdani42/nvim-tree.lua',
    config = "require('plugin.nvim-tree')",
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Misc
  use { 'cappyzawa/trim.nvim', config = "require('plugin.trim')" }
  use { 'numToStr/Comment.nvim', config = "require('plugin.comment')" }

  -- Completion
  use 'L3MON4D3/LuaSnip'
  use {
    'hrsh7th/nvim-cmp',
    after = 'LuaSnip',
    config = "require('plugin.cmp')",
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    }
  }

  use {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = "require('plugin.autopairs')"
  }

  use {
    'neovim/nvim-lspconfig',
    config = "require('plugin.lsp')",
    requires = {
      'williamboman/nvim-lsp-installer',
      { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = "require('plugin.treesitter')" },
      { 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    }
  }

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
