local M = {"lewis6991/gitsigns.nvim"}

M.event = { "BufReadPre", "BufNewFile" }

M.opts = {
    -- See `:help gitsigns.txt`
    signs = {
        add = { text = '+' },
        change = { text = '*' },
        delete = { text = '-' },
        topdelete = { text = '‾' },
        changedelete = { text = '*-' },
    }
}

return M
