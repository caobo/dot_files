local M = {'kylechui/nvim-surround'}

M.event ={ 'BufReadPost', 'BufNewFile'}

function M.config()
    require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
    })
end

return M
