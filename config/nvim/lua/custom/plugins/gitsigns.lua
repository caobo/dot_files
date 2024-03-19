local M = {"lewis6991/gitsigns.nvim"}

M.event = { "BufReadPre", "BufNewFile" }

M.opts = {
    -- See `:help gitsigns.txt`
--     signs = {
--         add = { text = '+' },
--         change = { text = '*' },
--         delete = { text = '-' },
--         topdelete = { text = '‾' },
--         changedelete = { text = '*-' },
--     }
}

vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")

return M
