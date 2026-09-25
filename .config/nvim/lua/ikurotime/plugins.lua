local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath })
    if vim.v.shell_error ~= 0 then error("Failed to install lazy.nvim: " .. out) end
end
vim.opt.rtp:prepend(lazypath)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("lazy").setup({
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    "nvim-telescope/telescope-file-browser.nvim",
    "sainnhe/everforest",
    "folke/tokyonight.nvim",
    { "catppuccin/nvim", name = "catppuccin" },
    "rebelot/kanagawa.nvim",
    "vimlab/split-term.vim",
    "wuelnerdotexe/vim-astro",
    -- The master compatibility branch supports the installed Neovim 0.11.
    { "nvim-treesitter/nvim-treesitter", branch = "master", build = ":TSUpdate" },
    { "ThePrimeagen/harpoon", branch = "master" },
    "windwp/nvim-ts-autotag",
    "windwp/nvim-autopairs",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "github/copilot.vim",
    "nvimtools/none-ls.nvim",
    "onsails/lspkind.nvim",
    "nvimdev/lspsaga.nvim",
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "neovim/nvim-lspconfig",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    { "nvim-tree/nvim-tree.lua", opts = {
        view = { width = 34 }, renderer = { group_empty = true },
        update_focused_file = { enable = true }, filters = { dotfiles = false },
    } },
    { "folke/which-key.nvim", opts = { delay = 350 } },
}, {
    defaults = { lazy = false },
    checker = { enabled = false },
    change_detection = { notify = false },
    rocks = { enabled = false },
})
