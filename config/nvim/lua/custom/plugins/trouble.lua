local plugin = {"folke/trouble.nvim"}

plugin.event ={ 'BufReadPost', 'BufNewFile'}
plugin.cmd = { 'TroubleToggle', 'Trouble' }
plugin.opts = { use_diagnostic_signs = true }

function plugin.config()
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

return plugin
