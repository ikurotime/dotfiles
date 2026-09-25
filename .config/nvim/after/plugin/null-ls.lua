local status, null_ls = pcall(require, "null-ls")
if (not status) then
    -- Try none-ls (null-ls fork)
    status, null_ls = pcall(require, "none-ls")
    if (not status) then return end
end

-- Build sources dynamically based on what's available
local sources = {}

-- Add prettierd/prettier formatting if available (for JS/TS/CSS/HTML/JSON)
if vim.fn.executable("prettierd") == 1 then
    table.insert(sources, null_ls.builtins.formatting.prettierd)
elseif vim.fn.executable("prettier") == 1 then
    table.insert(sources, null_ls.builtins.formatting.prettier)
end

-- Add stylua for Lua formatting if available
if vim.fn.executable("stylua") == 1 then
    table.insert(sources, null_ls.builtins.formatting.stylua)
end

-- Note: Language-specific formatting is handled by LSP servers:
-- - Go: gopls (with gofumpt)
-- - Rust: rust-analyzer
-- - Lua: lua_ls or stylua
-- - JavaScript/TypeScript: ESLint LSP (configured in lsp.lua) + prettierd
-- - CSS/HTML/JSON: prettierd

null_ls.setup {
    sources = sources,
    debug = false, -- Set to true if you want to see debug logs
}
