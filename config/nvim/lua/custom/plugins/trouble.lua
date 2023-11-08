local Plugin = {"folke/trouble.nvim"}

Plugin.event ={ 'BufReadPost', 'BufNewFile'}
Plugin.cmd = { 'TroubleToggle', 'Trouble' }
Plugin.opts = { use_diagnostic_signs = true }

function Plugin.config()
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

return Plugin
