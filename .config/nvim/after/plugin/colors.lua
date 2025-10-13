function ColorMyPencils(color)
    color = color or "everforest" -- Default colorscheme
    
    -- Try to load the colorscheme, fallback to default if not available
    local ok, _ = pcall(vim.cmd.colorscheme, color)
    if not ok then
        vim.notify("Colorscheme '" .. color .. "' not found. Run :PackerSync to install.", vim.log.levels.WARN)
        return
    end
    
    -- Make background transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
