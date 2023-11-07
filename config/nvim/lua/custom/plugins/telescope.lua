local plugin_tele = {"nvim-telescope/telescope.nvim"}

plugin_tele.dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim'
}

local plugin_fzf = {"nvim-telescope/telescope-fzf-native.nvim"}

plugin_fzf.build = 'make'

function plugin_fzf.cond()
    return vim.fn.executable 'make' == 1
end

local plugin = {plugin_tele,plugin_fzf}

return plugin
