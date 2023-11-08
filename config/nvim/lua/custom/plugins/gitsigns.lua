local Plugin = {"lewis6991/gitsigns.nvim"}

Plugin.event = { "BufReadPre", "BufNewFile" }
Plugin.opts = {
    -- See `:help gitsigns.txt`
    signs = {
        add = { text = '+' },
        change = { text = '*' },
        delete = { text = '-' },
        topdelete = { text = '‾' },
        changedelete = { text = '*-' },
    }
}

return Plugin
