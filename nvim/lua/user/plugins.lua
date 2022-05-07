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
  -- Have packer manage itself
  use 'wbthomason/packer.nvim'

  use 'folke/tokyonight.nvim'
  use 'itchyny/lightline.vim'
  use 'neovim/nvim-lspconfig'

  use {
    'cappyzawa/trim.nvim',
    config = "require('plugins.trim')"
  }
  
  use {
    'lewis6991/gitsigns.nvim',
    config = "require('plugins.gitsigns')"
  }

  use {
    'karb94/neoscroll.nvim',
    config = "require('plugins.neoscroll')"
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = "require('plugins.nvim-tree')",
    requires = {
      'kyazdani42/nvim-web-devicons'
    }
  }

  use {
    'nvim-telescope/telescope.nvim',
    config = "require('plugins.telescope')",
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-fzy-native.nvim'
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
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
