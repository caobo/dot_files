local M = {"folke/trouble.nvim"}

M.event ={ 'BufReadPost', 'BufNewFile'}
M.cmd = { 'TroubleToggle', 'Trouble' }
M.opts = { use_diagnostic_signs = true }

function M.config()
    require('trouble').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',
        {silent = true, noremap = true}),
        vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
        {silent = true, noremap = true}),
        vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',
        {silent = true, noremap = true}),
        vim.keymap.set("n", "<leader>xr",
        function() require("trouble").toggle("lsp_references") end )     -- refer to the configuration section below
    }
end

_ = M

return {}
