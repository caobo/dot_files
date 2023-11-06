return{
    'folke/trouble.nvim',
    -- event = 'VeryLazy',
    event ={ 'BufReadPost', 'BufNewFile'},
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    -- dependencies ={ 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' },
    config = function()
        require('trouble').setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',
            -- {silent = true, noremap = true}),
            vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
                {silent = true, noremap = true}),
            vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',
                {silent = true, noremap = true}),
            -- refer to the configuration section below
        }
    end
}
