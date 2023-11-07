local plugin = {'kylechui/nvim-surround'}

plugin.event ={ 'BufReadPost', 'BufNewFile'}

function plugin.config()
    require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
    })
end

return plugin
