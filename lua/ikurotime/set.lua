vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true 
vim.api.nvim_set_hl(0, "CursorLineNr", { cterm=bold, bold=false,fg="#FFD191"})
vim.opt.tabstop = 4
vim.opt.softtabstop= 4
vim.opt.shiftwidth= 4
vim.opt.expandtab= true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.hlsearch = false
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.g.mapleader = " "

