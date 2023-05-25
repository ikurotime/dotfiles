vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v","J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v","K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n","<leader>k","<C-w>k")
vim.keymap.set("n","<leader>j","<C-w>j")
vim.keymap.set("n","<leader>l","<C-w>l")
vim.keymap.set("n","<leader>h","<C-w>h")

vim.keymap.set("n","<leader>K","<C-w>K")
vim.keymap.set("n","<leader>J","<C-w>J")
vim.keymap.set("n","<leader>L","<C-w>L")
vim.keymap.set("n","<leader>H","<C-w>H")

vim.keymap.set("n","<leader>vv","<cmd>:vs<CR>")
vim.keymap.set("n","<leader>bb","<cmd>:split horizontal<CR>")

vim.keymap.set("n","<leader>s","<cmd>:w<CR>")
vim.keymap.set("n","<leader>q","<cmd>:q<CR>")
