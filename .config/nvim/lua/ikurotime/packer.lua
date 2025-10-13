-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.vim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({ 'nvim-telescope/telescope-file-browser.nvim' })
    
    -- Color scheme
    use {
        'sainnhe/everforest',
        as = 'everforest',
    }
    
    use('vimlab/split-term.vim')
    use('wuelnerdotexe/vim-astro')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('windwp/nvim-ts-autotag')
    use('windwp/nvim-autopairs')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('github/copilot.vim')
    use('nvimtools/none-ls.nvim') -- null-ls fork (actively maintained)
    use('simrat39/rust-tools.nvim')
    use('onsails/lspkind-nvim')
    use('glepnir/lspsaga.nvim')
    use('kyazdani42/nvim-web-devicons')
    use('lewis6991/gitsigns.nvim')
    
    -- LSP Support
    use('neovim/nvim-lspconfig')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    
    -- Autocompletion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')
    use('saadparwaiz1/cmp_luasnip')
    
    -- Snippets
    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')
end)
