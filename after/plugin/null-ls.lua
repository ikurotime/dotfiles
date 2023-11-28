local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

null_ls.setup {
    sources = {
        null_ls.builtins.formatting.prettierd.with({
            condition = function()
                return require "null-ls.utils".root_pattern(
                    ".prettierrc",
                    ".prettierrc.json",
                    ".prettierrc.yml",
                    ".prettierrc.yaml",
                    ".prettierrc.json5",
                    ".prettierrc.js",
                    ".prettierrc.cjs",
                    ".prettierrc.toml",
                    "prettier.config.js",
                    "prettier.config.cjs"
                )(vim.api.nvim_buf_get_name(0)) ~= nil
            end,
        }),
        null_ls.builtins.diagnostics.eslint_d.with({
            condition = function()
                return require "null-ls.utils".root_pattern(
                    ".eslintrc",
                    ".eslintrc.json",
                    ".eslintrc.js",
                    ".eslintrc.cjs",
                    ".eslintrc.yaml",
                    ".eslintrc.yml",
                    ".eslintrc.json"
                )(vim.api.nvim_buf_get_name(0)) ~= nil
            end,
            diagnostics_format = '[eslint] #{m}\n(#{c})',
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    lsp_formatting(bufnr)
                end,
            })
        end
    end
}

vim.api.nvim_create_user_command(
    'DisableLspFormatting',
    function()
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
    end,
    { nargs = 0 }
)
