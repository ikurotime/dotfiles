-- Neovim 0.11 native LSP configuration.

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Helper function to safely setup LSP servers
local function setup_server(server_name, config)
    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
end

-- Flow
setup_server('flow', {
    on_attach = on_attach,
    capabilities = capabilities
})

-- Rust Analyzer
setup_server('rust_analyzer', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
        }
    }
})

-- Clangd
setup_server('clangd', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    init_options = {
        clangdFileStatus = true
    }
})

-- Go
setup_server('gopls', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            gofumpt = true, -- Use gofumpt for stricter formatting
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
})

-- Elixir
setup_server('elixirls', {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "elixir-ls" },
    filetypes = { "elixir" },
})

-- Vue (Volar)
setup_server('vue_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "vue" },
})

-- TypeScript
setup_server('ts_ls', {
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = capabilities
})

-- Swift (SourceKit)
setup_server('sourcekit', {
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Lua
setup_server('lua_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
        },
    },
})

-- Tailwind CSS
setup_server('tailwindcss', {
    on_attach = on_attach,
    capabilities = capabilities
})

-- CSS
setup_server('cssls', {
    on_attach = on_attach,
    capabilities = capabilities
})

-- Astro
setup_server('astro', {
    on_attach = on_attach,
    capabilities = capabilities
})

-- ESLint
setup_server('eslint', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        format = { enable = true }, -- Enable ESLint formatting
        codeActionOnSave = {
            enable = false, -- Disable auto code actions (we use format on save instead)
        },
    },
})

vim.diagnostic.config({
    underline = true,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
    update_in_insert = false,
    float = { source = "always" },
})

-- Global format on save as a fallback (for telescope-opened files)
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("GlobalLspFormat", { clear = true }),
    pattern = "*",
    callback = function(ev)
        local buf = ev.buf

        -- Check if this buffer has any LSP clients with formatting capability
        local clients = vim.lsp.get_clients({ bufnr = buf })
        local has_formatter = false

        for _, client in ipairs(clients) do
            if client.supports_method("textDocument/formatting") then
                has_formatter = true
                break
            end
        end

        if has_formatter then
            vim.lsp.buf.format({
                bufnr = buf,
                timeout_ms = 2000,
                filter = function(client)
                    -- Use none-ls when an external formatter is available.
                    local sources = require("null-ls.sources")
                    local methods = require("null-ls.methods")
                    local available = sources.get_available(vim.bo[buf].filetype, methods.internal.FORMATTING)
                    return #available == 0 or client.name == "null-ls"
                end,
            })
        end
    end,
})
