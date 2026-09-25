local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: bookmark file" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: show bookmarks" })

vim.keymap.set("n", "<C-b>", function() ui.nav_file(1) end, { desc = "Harpoon: open bookmark 1" })
vim.keymap.set("n", "<C-n>", function() ui.nav_file(2) end, { desc = "Harpoon: open bookmark 2" })
vim.keymap.set("n", "<C-m>", function() ui.nav_file(3) end, { desc = "Harpoon: open bookmark 3" })
vim.keymap.set("n", "<C-h>", function() ui.nav_file(4) end, { desc = "Harpoon: open bookmark 4" })
vim.keymap.set("n", "<C-y>", function() ui.nav_file(5) end, { desc = "Harpoon: open bookmark 5" })
