local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')
local util = require('lspconfig/util')

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

protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Helper function to safely setup LSP servers
local function setup_server(server_name, config)
    local ok, server = pcall(function() return nvim_lsp[server_name] end)
    if ok and server then
        server.setup(config)
    end
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
    root_dir = util.root_pattern("Cargo.toml"),
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
setup_server('volar', {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "vue" },
})

-- TypeScript
setup_server('ts_ls', {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
    }
)

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '●'
    },
    update_in_insert = true,
    float = {
        source = "always", -- Or "if_many"
    },
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
            })
        end
    end,
})
