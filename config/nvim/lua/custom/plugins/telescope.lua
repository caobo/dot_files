-- Fuzzy Finder
local M = { 'nvim-telescope/telescope.nvim' }

M.dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
}

M.cmd = 'Telescope'

function M.init()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }


    -- set background to transparent
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })

    -- Search pattern
    map('n', '<leader>/', '<cmd>Telescope builtin<cr>', { desc = "Buildin pickers", unpack(opts) })
    -- Show key bindings list
    map('n', '<leader>?', '<cmd>Telescope keymaps<cr>', { desc = "Keymaps", unpack(opts) })
    -- Find files by name
    map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = "[f]ind [f]ile in current directory", unpack(opts) })
    -- Find files by name in current git repo
    map('n', '<leader>fp', '<cmd>Telescope git_files<cr>', { desc = "[f]ind file in whole [p]roject", unpack(opts) })
    -- Search symbols in buffer
    map('n', '<leader>fw', '<cmd>Telescope current_buffer_fuzzy_find<cr>',
        { desc = "[f]ind [w]ord in current buffer", unpack(opts) })
    map('n', '<leader>fW', '<cmd>Telescope live_grep<cr>', { desc = "[f]ind [w]ord using live grep", unpack(opts) })
    map('n', '<leader>fg', '<cmd>Telescope grep_string<cr>', { desc = "Grap current word", unpack(opts) })
    -- Search in files history
    map('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>', { desc = "[f]ind [h]istory", unpack(opts) })
    -- Search in active buffers list
    map('n', '<leader><space>', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>',
        { desc = "buffer list", unpack(opts) })
    -- Search refernces using lsp
    map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "[f]ind [r]eference (lsp)", unpack(opts) })
    -- Search symbols in document
    map('n', '<leader>fd', "<cmd>Telescope lsp_document_symbols<cr>",
        { desc = "[f]ind symbol in current [d]ocument (lsp)", unpack(opts) })
    -- Search symbols in workplace
    map('n', '<leader>fs', "<cmd>Telescope lsp_workspace_symbols<cr>",
        { desc = "[f]ind symbol in work[s]pace (lsp)", unpack(opts) })
    -- Spell suggestions
    map('n', '<leader>sp', "<cmd> Telescope spell_suggest<cr>", { desc = "[s][p]ell check", unpack(opts) })
end

function M.config()
    local telescope = require('telescope')
    local actions = require('telescope.actions')


    local function default_view(title, previewer)
        return {
            prompt_title = title,
            previewer = previewer or false,
            results_title = false,
            theme = 'ivy'
        }
    end

    local function dropdown_view(title, previewer)
        return {
            prompt_title = title,
            previewer = previewer or false,
            theme = 'dropdown',
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    width = { padding = 0 },
                    height = { padding = 0 },
                },
            }
        }
    end

    telescope.setup({
        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        },
        defaults = {
            borderchars = { "─", "│", "─", "│", "●", "●", "●", "●" },

            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                    ['<M-b>'] = actions.select_default,
                    ['<C-q>'] = actions.smart_send_to_qflist,
                    ['<C-Q>'] = actions.smart_add_to_qflist,
                    ['<C-x>'] = actions.delete_buffer,
                    ['<esc>'] = actions.close,
                },
                n = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                    ['<C-q>'] = actions.smart_send_to_qflist,
                    ['<C-Q>'] = actions.smart_add_to_qflist,
                    ['C-c'] = actions.close,
                    ['d'] = actions.delete_buffer,
                }
            },

            -- Default layout options
            prompt_prefix = ' ',
            selection_caret = '❯ ',
            layout_strategy = 'horizontal',
            sorting_strategy = 'ascending',
            layout_config = {
                preview_cutoff = 10,
                mirror = false,
                prompt_position = 'bottom',
                preview_width = 0.6,
            },
        },

        pickers = {
            lsp_document_symbols = default_view("Symbols in current file", true),
            buffers = dropdown_view('Buffers activated'),
            find_files = default_view('Files in this workspace', true),
            oldfiles = default_view('Recents'),
            keymaps = dropdown_view(),
            command_history = dropdown_view(),
            colorscheme = dropdown_view(),
            spell_suggest = dropdown_view('Spell sugesstions'),
            grep_string = default_view('Grap and search for the current word', true),
            live_grep = default_view('Searching for...', true),
            treesitter = default_view('Buffer Symbols (treesitter)'),
            current_buffer_fuzzy_find = default_view('Lines'),
            commands = default_view(),
            help_tags = default_view(),
        },
    })

    require('telescope').load_extension('fzf')
end

return M
