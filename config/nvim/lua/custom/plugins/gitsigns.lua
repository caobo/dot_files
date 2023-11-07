local plugin = {"lewis6991/gitsigns.nvim"}

plugin.event = { "BufReadPre", "BufNewFile" }
plugin.opts = {
    -- See `:help gitsigns.txt`
    signs = {
        add = { text = '+' },
        change = { text = '*' },
        delete = { text = '-' },
        topdelete = { text = '‾' },
        changedelete = { text = '*-' },
    }
}

return plugin
