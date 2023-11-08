local Plugin = {'kylechui/nvim-surround'}

Plugin.event ={ 'BufReadPost', 'BufNewFile'}

function Plugin.config()
    require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
    })
end

return Plugin
