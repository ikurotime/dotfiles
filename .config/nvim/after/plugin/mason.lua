require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "tailwindcss", "ts_ls", "vue_ls", "eslint", "elixirls", "astro", "gopls", "lua_ls", "rust_analyzer" },
    automatic_enable = false, -- Configured explicitly in lsp.lua.
})
