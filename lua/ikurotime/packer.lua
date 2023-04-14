-- This file can be loaded by calling `lua require('plugins')` from your init.vim
ColorMyPencils()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.vim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or 			, branch = '0.1.x'
   requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
	'rose-pine/neovim',
	as = 'rose-pine',
	config = function()
		vim.cmd('colorscheme rose-pine')
	end
  })
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('windwp/nvim-ts-autotag')
  use('windwp/nvim-autopairs')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('github/copilot.vim')
  use('jose-elias-alvarez/null-ls.nvim')
  use('simrat39/rust-tools.nvim') -- extra functionality over rust-analyzer
  use('MunifTanjim/prettier.nvim')
  use {
  'VonHeikemen/lsp-zero.nvim',
  requires = {
  {'lewis6991/gitsigns.nvim'}, -- Git decorators
  -- LSP Support
  {'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  -- Autocompletion
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'saadparwaiz1/cmp_luasnip'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-nvim-lua'},
  -- Snippets
  {'L3MON4D3/LuaSnip'},
  {'rafamadriz/friendly-snippets'},
  }
  }
end)
