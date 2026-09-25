require("gitsigns").setup({
    on_attach = function(buf)
        local gs = require("gitsigns")
        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
        end, { buffer = buf, desc = "Next changed hunk" })
        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
        end, { buffer = buf, desc = "Previous changed hunk" })
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = buf, desc = "Preview changed hunk" })
    end,
})
