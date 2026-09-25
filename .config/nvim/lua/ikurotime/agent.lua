local M = {}
local terminals = {}

function M.root()
    local name = vim.api.nvim_buf_get_name(0)
    local start = vim.bo.buftype == "" and name ~= "" and name or vim.fn.getcwd()
    return vim.fs.root(start, ".git") or vim.fn.getcwd()
end

function M.copy_context(selection)
    local name = vim.api.nvim_buf_get_name(0)
    if name == "" or vim.bo.buftype ~= "" then
        vim.notify("Open a file to copy its reference", vim.log.levels.WARN)
        return
    end
    local root = M.root()
    local relative = vim.fs.relpath(root, name) or name
    local first, last = vim.fn.line("."), vim.fn.line(".")
    if selection then
        first, last = vim.fn.line("v"), vim.fn.line(".")
        if first > last then first, last = last, first end
    end
    local reference = relative .. ":" .. first .. (last ~= first and ("-" .. last) or "")
    local text = "Project: " .. root .. "\n" .. reference
    if selection then
        text = text .. "\n\n```" .. vim.bo.filetype .. "\n"
            .. table.concat(vim.api.nvim_buf_get_lines(0, first - 1, last, false), "\n") .. "\n```"
    end
    vim.fn.setreg('"', text)
    if vim.fn.has("clipboard") == 1 then vim.fn.setreg("+", text) end
    vim.notify("Copied " .. reference)
end

function M.toggle_terminal()
    if vim.fn.executable("codex") ~= 1 then
        vim.notify("Install the Codex CLI and put codex on PATH, then run codex login", vim.log.levels.WARN)
        return
    end
    local root = vim.b.codex_root or M.root()
    local session = terminals[root]
    if session and vim.api.nvim_buf_is_valid(session.buf) then
        local win = vim.fn.bufwinid(session.buf)
        if win ~= -1 then
            vim.api.nvim_win_hide(win)
            return
        end
        if vim.fn.jobwait({ session.job }, 0)[1] == -1 then
            vim.cmd("botright 16split")
            vim.api.nvim_win_set_buf(0, session.buf)
            vim.cmd.startinsert()
            return
        end
    end
    vim.cmd("botright 16new")
    local buf = vim.api.nvim_get_current_buf()
    vim.bo.bufhidden = "hide"
    vim.b.codex_root = root
    local job = vim.fn.jobstart({ "codex" }, { term = true, cwd = root })
    if job <= 0 then
        vim.notify("Could not start Codex", vim.log.levels.ERROR)
        return
    end
    terminals[root] = { buf = buf, job = job }
    vim.keymap.set("t", "<C-\\><C-n>", "<C-\\><C-n>", { buffer = buf, desc = "Leave terminal input" })
    vim.keymap.set({ "n", "t" }, "<M-a>", M.toggle_terminal, { buffer = buf, desc = "Hide Codex terminal" })
    vim.cmd.startinsert()
end

function M.setup()
    vim.opt.autoread = true
    local group = vim.api.nvim_create_augroup("AgentFileRefresh", { clear = true })
    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
        group = group,
        callback = function()
            vim.schedule(function()
                if vim.fn.getcmdwintype() == "" and vim.fn.mode() ~= "c" then
                    vim.cmd("checktime")
                end
            end)
        end,
    })
    vim.api.nvim_create_user_command("AgentContext", function(opts) M.copy_context(opts.bang) end, { bang = true })
    vim.api.nvim_create_user_command("Codex", M.toggle_terminal, {})
    vim.api.nvim_create_user_command("FormatToggle", function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
    end, {})
    vim.keymap.set("n", "<leader>ac", function() M.copy_context(false) end, { desc = "Copy file reference for agent" })
    vim.keymap.set("x", "<leader>ac", function() M.copy_context(true) end, { desc = "Copy selected lines for agent" })
    vim.keymap.set("n", "<leader>aa", M.toggle_terminal, { desc = "Toggle Codex terminal" })
    vim.keymap.set("n", "<leader>tf", "<cmd>FormatToggle<CR>", { desc = "Toggle format on save" })
    vim.keymap.set("n", "<leader>ar", "<cmd>checktime<CR>", { desc = "Refresh agent file changes" })
    vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Review current file diff" })
end
return M
