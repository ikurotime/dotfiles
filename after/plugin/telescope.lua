local status, telescope = pcall(require, 'telescope')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fw', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>fl', builtin.resume, {})

local function document_symbols_for_selected(prompt_bufnr)
    local action_state = require("telescope.actions.state")
    local actions = require("telescope.actions")
    local entry = action_state.get_selected_entry()

    if entry == nil then
        print("No file selected")
        return
    end

    actions.close(prompt_bufnr)

    vim.schedule(function()
        local bufnr = vim.fn.bufadd(entry.path)
        vim.fn.bufload(bufnr)

        local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }

        vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", params, function(err, result, _, _)
            if err then
                print("Error getting document symbols: " .. vim.inspect(err))
                return
            end

            if not result or vim.tbl_isempty(result) then
                print("No symbols found")
                return
            end

            local function flatten_symbols(symbols, parent_name)
                local flattened = {}
                for _, symbol in ipairs(symbols) do
                    local name = symbol.name
                    if parent_name then
                        name = parent_name .. "." .. name
                    end
                    table.insert(flattened, {
                        name = name,
                        kind = symbol.kind,
                        range = symbol.range,
                        selectionRange = symbol.selectionRange,
                    })
                    if symbol.children then
                        local children = flatten_symbols(symbol.children, name)
                        for _, child in ipairs(children) do
                            table.insert(flattened, child)
                        end
                    end
                end
                return flattened
            end

            local flat_symbols = flatten_symbols(result)

            -- Define highlight group for symbol kind
            vim.cmd([[highlight TelescopeSymbolKind guifg=#61AFEF]])

            require("telescope.pickers").new({}, {
                prompt_title = "Document Symbols: " .. vim.fn.fnamemodify(entry.path, ":t"),
                finder = require("telescope.finders").new_table({
                    results = flat_symbols,
                    entry_maker = function(symbol)
                        local kind = vim.lsp.protocol.SymbolKind[symbol.kind] or "Other"
                        return {
                            value = symbol,
                            display = function(entry)
                                local display_text = string.format("%-50s %s", entry.value.name, kind)
                                return display_text,
                                    { { { #entry.value.name + 1, #display_text }, "TelescopeSymbolKind" } }
                            end,
                            ordinal = symbol.name,
                            filename = entry.path,
                            lnum = symbol.selectionRange.start.line + 1,
                            col = symbol.selectionRange.start.character + 1,
                        }
                    end,
                }),
                sorter = require("telescope.config").values.generic_sorter({}),
                previewer = require("telescope.config").values.qflist_previewer({}),
                attach_mappings = function(_, map)
                    map("i", "<CR>", function(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        vim.cmd("edit " .. selection.filename)
                        vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
                    end)
                    return true
                end,
            }):find()
        end)
    end)
end

telescope.setup({
    file_ignore_patterns = { "%.git/." },
    defaults = {
        mappings = {
            i = {

                ["<C-s>"] = document_symbols_for_selected,
            },

            n = {
                ["<C-s>"] = document_symbols_for_selected,
            },


        },
        -- path_display = formattedName,
        path_display = {
            "filename_first",
        },
        previewer = false,
        file_ignore_patterns = { "node_modules", "package-lock.json" },
        initial_mode = "insert",
        select_strategy = "reset",
        sorting_strategy = "ascending",
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        layout_config = {
            prompt_position = "top",
            preview_cutoff = 120,
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
        },
    },
    pickers = {
        find_files = {
            -- path_display = formattedName,
            layout_config = {
                prompt_position = "bottom",
                preview_cutoff = 120,
            },
        },
        git_files = {
            previewer = false,
            -- path_display = formattedName,
            layout_config = {
                height = 0.4,
                prompt_position = "top",
                preview_cutoff = 120,
            },
        },
        previewer = false,
        initial_mode = "normal",
        -- theme = "dropdown",
        layout_config = {
            height = 0.4,
            width = 0.6,
            prompt_position = "top",
            preview_cutoff = 120,
        },
    },
    current_buffer_fuzzy_find = {
        previewer = true,
        layout_config = {
            prompt_position = "top",
            preview_cutoff = 120,
        },
    },
    live_grep = {
        only_sort_text = true,
        previewer = true,
    },
    grep_string = {
        only_sort_text = true,
        previewer = true,
    },
    lsp_references = {
        show_line = false,
        previewer = true,
    },
    treesitter = {
        show_line = false,
        previewer = true,
    },
    colorscheme = {
        enable_preview = true,
    }
})
