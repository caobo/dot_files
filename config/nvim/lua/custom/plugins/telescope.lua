-- Fuzzy Finder
local M = {'nvim-telescope/telescope.nvim'}

M.dependencies = {
    {'nvim-lua/plenary.nvim'},
}

M.cmd = 'Telescope'

function M.init()
    local map = vim.keymap.set
    local opts = {remap = false}
    -- Search pattern
    map('n', '<leader>fg', '<cmd>Telescope grep_string<cr>', opts)
    map('n', '<leader>fG', '<cmd>Telescope live_grep<cr>', opts)
    -- Show key bindings list
    map('n', '<leader>?', '<cmd>Telescope keymaps<cr>', opts)
    -- Find files by name
    map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
    -- Find files by name in current git repo
    map('n', '<leader>fp', '<cmd>Telescope git_files<cr>', opts)
    -- Search symbols in buffer
    map('n', '<leader>fs', '<cmd>Telescope treesitter<cr>', opts)
    -- Search buffer lines
    map('n', '<leader>fw', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)
    -- Search in files history
    map('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>', opts)
    -- Search in active buffers list
    map('n', '<leader>bb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', opts)
    -- Search refernces using lsp
    map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", opts)
    -- Search symbols in document
    map('n', '<leader>fd', "<cmd>Telescope lsp_document_symbols<cr>", opts)
    -- Search symbols in workplace
    map('n', '<leader>fq', "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
end

function M.config()

    local telescope = require('telescope')
    local actions = require('telescope.actions')

    local function defaults(title, previewer)
        return {
            prompt_title = title,
            previewer = previewer or false,
            results_title = false,
            theme = 'ivy'
        }
    end

    local function dropdown(title, previewer)
        return {
            prompt_title = title,
            previewer = previewer or false,
            theme = 'dropdown',
            layout_config = {
                prompt_position = "top"
            }
        }
    end

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                    ['<M-b>'] = actions.select_default,
                    ['<C-q>'] = actions.smart_send_to_qflist,
                    ['<C-Q>'] = actions.smart_add_to_qflist,
                    ['<C-x>'] = actions.delete_buffer,
                    -- ['<esc>'] = actions.close,
                },
                n = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                    ['<C-q>'] = actions.smart_send_to_qflist,
                    ['<C-Q>'] = actions.smart_add_to_qflist,
                    ['d'] = actions.delete_buffer,
                    ['q'] = actions.close
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
                prompt_position = 'bottom'
            },
        },
        pickers = {
            buffers = dropdown('Buffers activated'),
            find_files = defaults('Files in this workspace', true),
            oldfiles = defaults('Recents'),
            keymaps = dropdown(),
            command_history = dropdown(),
            colorscheme = dropdown(),

            grep_string = defaults('Search'),
            treesitter = defaults('Buffer Symbols (treesitter)'),
            current_buffer_fuzzy_find = defaults('Lines'),
            live_grep = defaults('Grep'),

            commands = defaults(),
            help_tags = defaults(),
        },
    })
end

return M
