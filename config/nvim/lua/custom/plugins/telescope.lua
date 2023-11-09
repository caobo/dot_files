-- Fuzzy Finder
local Plugin = {'nvim-telescope/telescope.nvim'}
local user = {}

Plugin.dependencies = {
    {'nvim-lua/plenary.nvim'},
    {
        'nvim-telescope/telescope-fzy-native.nvim',
        build = function() user.build_fzy() end
    }
}

Plugin.cmd = 'Telescope'

function Plugin.init()
    local keybind = vim.keymap.set
    local opts = {remap = false}
    -- Search pattern
    keybind('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
    -- Show key bindings list
    keybind('n', '<leader>?', '<cmd>Telescope keymaps<cr>', opts)
    -- Find files by name
    keybind('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
    -- Search symbols in buffer
    keybind('n', '<leader>fs', '<cmd>Telescope treesitter<cr>', opts)
    -- Search buffer lines
    keybind('n', '<leader>fw', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)
    -- Search in files history
    keybind('n', '<leader>fh', '<cmd>Telescope oldfiles<cr>', opts)
    -- Search in active buffers list
    keybind('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
    -- Search symbols in document and workplace
    keybind('n', '<leader>fd', "<cmd>Telescope lsp_document_symbols<cr>", opts)
    keybind('n', '<leader>fq', "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
end

function Plugin.config()
    local command = vim.api.nvim_create_user_command

    local telescope = require('telescope')
    local actions = require('telescope.actions')

    command('TGrep', function(input)
        require('telescope.builtin').grep_string({search = input.args})
    end, {nargs = 1})

    local function defaults(title)
        return {
            prompt_title = title,
            results_title = false
        }
    end

    local function dropdown(title, previewer)
        return {
            prompt_title = title,
            previewer = previewer or false,
            theme = 'dropdown'
        }
    end

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                    ["<C-Enter>"] = actions.select_vertical,
                    ['<esc>'] = actions.close,
                    ['<M-b>'] = actions.select_default,
                },
                n = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                    ["<C-Enter>"] = actions.select_vertical,
                },
            },

            -- Default layout options
            prompt_prefix = ' ',
            selection_caret = '❯ ',
            layout_strategy = 'vertical',
            sorting_strategy = 'ascending',
            layout_config = {
                preview_cutoff = 10,
                mirror = true,
                prompt_position = 'top'
            },
        },
        pickers = {
            buffers = dropdown(),
            find_files = dropdown(),
            oldfiles = defaults("Recents"),
            keymaps = dropdown(),
            command_history = dropdown(),
            colorscheme = dropdown(),

            grep_string = defaults('Search'),
            treesitter = defaults('Buffer Symbols'),
            current_buffer_fuzzy_find = defaults('Lines'),
            live_grep = defaults('Grep'),

            commands = defaults(),
            help_tags = defaults(),
        },
        extension = {
            fzy_native = {
                override_generic_sorter = true,
                override_file_sorter = true
            },
        }
    })

    telescope.load_extension('fzy_native')
end

function user.job_output(cid, data, name)
    for i, val in pairs(data) do
        print(val)
    end
end

function user.build_fzy()
    if vim.fn.executable('make') == 0 then
        return
    end

    local workdir = vim.api.nvim_get_runtime_file('deps/fzy-lua-native', 1)

    if workdir[1] == nil then
        return
    end

    vim.fn.jobstart({'make'}, {
        cwd = workdir[1],
        on_stdout = user.job_output,
    })
end

return Plugin
