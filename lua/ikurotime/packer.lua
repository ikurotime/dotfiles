-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--ColorMyPencils()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.vim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or 			, branch = '0.1.x'
        requires = { { 'nvim-lua/plenary.nvim' } }

    }
    use({
        "themercorp/themer.lua",
        config = function()
            require("themer").setup({
                colorscheme = "sonokai_deep",
                styles = {
                    ["function"]    = { style = 'italic' },
                    functionbuiltin = { style = 'italic' },
                    variable        = { style = 'italic' },
                    variableBuiltIn = { style = 'italic' },
                    parameter       = { style = 'italic' },
                },
            })
        end
    })
    use({ 'nvim-telescope/telescope-file-browser.nvim' })
    --  use ({ "catppuccin/nvim", as = "catppuccin",
    --  config = function()
    --            vim.cmd("colorscheme catppuccin" )
    --    end
    --})
    --use({
    --    "ellisonleao/gruvbox.nvim",
    --    as = "gruvbox",
    --    config = function()
    --        vim.cmd("colorscheme gruvbox")
    --    end
    --})
    --  use({
    --	'rose-pine/neovim',
    --	as = 'rose-pine',
    --	config = function()
    --		vim.cmd('colorscheme rose-pine')
    --	end
    -- })
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
    use('jose-elias-alvarez/null-ls.nvim')
    use('simrat39/rust-tools.nvim') -- extra functionality over ru.load_extension('file_/st-analyzer
    use('MunifTanjim/prettier.nvim')
    use('onsails/lspkind-nvim')
    use('glepnir/lspsaga.nvim')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-nvim-lsp')
    use('kyazdani42/nvim-web-devicons')
    use('hrsh7th/nvim-cmp')
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            { 'lewis6991/gitsigns.nvim' }, -- Git decorators
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
end)
