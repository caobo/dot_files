-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
--
local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
  return
end

local actions = require "telescope.actions"
-- local config = require "telescope.config"

telescope.setup {
    defaults = {
        layout_config = {
            -- preview_width = 0.6,
            -- prompt_position = "top",
        },
        prompt_prefix = "  ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        path_display = { "smart" },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        -- border = {},
        -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        extensions = {
            file_browser = {
                -- theme = "rose-pone",
                -- disables netrw and use telescope-file-browser in its place
                -- hijack_netrw = true,
                mappings = {
                    ["i"] = {
                        -- your custom insert mode mappings
                    },
                    ["n"] = {
                        -- your custom normal mode mappings
                    },
                },
            },
        },
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ["<C-Enter>"] = actions.select_vertical,
                ["<A-Enter>"] = actions.select_tab,
            },
            n = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ["<C-Enter>"] = actions.select_vertical,
                ["<A-Enter>"] = actions.select_tab,
            },
        },
    },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require("telescope").load_extension, "file_browser")

-- See `:help telescope.builtin`
vim.keymap.set(
    'n',
    '<leader>fr',
    require('telescope.builtin').oldfiles,
    { desc = '[F]ind [R]ecently opened files'}
)

vim.keymap.set(
    'n',
    '<leader>/',
    function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        -- require('telescope.builtin').current_buffer_fuzzy_find(
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 30,
            previewer = false, }
        )end,
    { desc = '[/] Fuzzily search in current buffer' }
)

vim.keymap.set(
    "n",
    "<leader><space>",
    ":Telescope file_browser path=%:p:h hidden=true select_buffer=true dir_icon_hl=MyHighlightGroup<Cr>",
    { desc = 'File browser'}
    -- { noremap = true },
)

vim.keymap.set('n', '<leader>fp', require('telescope.builtin').git_files, { desc = '[F]ind files in current git [P]roject'})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind existing [B]uffers' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
