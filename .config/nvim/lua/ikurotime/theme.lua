local M = {}
local path = vim.fn.stdpath("state") .. "/theme.json"

function M.apply(name, save)
    local ok, err = pcall(vim.cmd.colorscheme, name)
    if not ok then
        vim.notify("Cannot load theme " .. name .. ": " .. tostring(err), vim.log.levels.WARN)
        return false
    end
    if save then
        vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
        local written, failure = pcall(vim.fn.writefile,
            { vim.json.encode({ name = name, background = vim.o.background }) }, path)
        if not written then vim.notify("Could not save theme: " .. tostring(failure), vim.log.levels.ERROR) end
    end
    return true
end

function M.pick()
    require("telescope.builtin").colorscheme({
        enable_preview = true,
        attach_mappings = function(bufnr)
            local actions = require("telescope.actions")
            actions.select_default:replace(function()
                local entry = require("telescope.actions.state").get_selected_entry()
                actions.close(bufnr)
                if entry then M.apply(entry.value, true) end
            end)
            return true
        end,
    })
end

function M.setup()
    -- Preserve the transparent background from the original configuration.
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("ThemeOverrides", { clear = true }),
        callback = function()
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    })
    local name = "everforest"
    if vim.fn.filereadable(path) == 1 then
        local ok, saved = pcall(function() return vim.json.decode(table.concat(vim.fn.readfile(path), "\n")) end)
        if ok and type(saved) == "table" and type(saved.name) == "string" then
            name = saved.name
            if saved.background == "light" or saved.background == "dark" then vim.o.background = saved.background end
        end
    end
    if not M.apply(name, false) then M.apply("everforest", false) end
    vim.api.nvim_create_user_command("Theme", function(opts)
        if opts.args == "" then M.pick() else M.apply(opts.args, true) end
    end, { nargs = "?", complete = "color", desc = "Choose and save a theme" })
end
return M
