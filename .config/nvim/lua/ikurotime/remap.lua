vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Focus window above" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Focus window below" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Focus window right" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Focus window left" })
vim.keymap.set("n", "<leader>x", function()
    if vim.fn.executable("chmod") ~= 1 then
        vim.notify("chmod is not installed", vim.log.levels.WARN)
        return
    end
    vim.fn.system({ "chmod", "+x", vim.fn.expand("%:p") })
end, { desc = "Make file executable" })
vim.keymap.set("n", "<C-f>", function()
    if vim.fn.executable("tmux") ~= 1 or vim.fn.executable("tmux-sessionizer") ~= 1 then
        vim.notify("This shortcut needs tmux and tmux-sessionizer on PATH", vim.log.levels.WARN)
        return
    end
    vim.fn.system({ "tmux", "neww", "tmux-sessionizer" })
end, { desc = "Open tmux sessionizer" })

vim.keymap.set("n", "<leader>K", "<C-w>K", { desc = "Move window to top" })
vim.keymap.set("n", "<leader>J", "<C-w>J", { desc = "Move window to bottom" })
vim.keymap.set("n", "<leader>L", "<C-w>L", { desc = "Move window to right" })
vim.keymap.set("n", "<leader>H", "<C-w>H", { desc = "Move window to left" })

vim.keymap.set("n", "<leader>vv", "<cmd>:vs<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>bb", "<cmd>split<CR>", { desc = "Split horizontally" })

-- Save and format (format on save is handled by null-ls automatically)
vim.keymap.set("n", "<leader>s", "<cmd>:w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>:q<CR>", { desc = "Close window" })

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal file in tree" })
vim.keymap.set("n", "<leader>tt", "<cmd>Theme<CR>", { desc = "Choose theme" })
vim.keymap.set("n", "<leader>?", "<cmd>Keybindings<CR>", { desc = "Search keybindings" })
vim.api.nvim_create_user_command("Keybindings", function()
    require("telescope.builtin").keymaps()
end, { desc = "Search all keybindings" })
