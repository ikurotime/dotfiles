local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup {}
lspconfig.setup {
    ensure_installed = { "tailwindcss", "ts_ls", "volar", "eslint", "elixirls", "astro", "gopls",
        "lua_ls", "rust_analyzer" }

}
require 'lspconfig'.tailwindcss.setup {}
