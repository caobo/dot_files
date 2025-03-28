local M = { "lewis6991/gitsigns.nvim" }

M.event = { "BufReadPre", "BufNewFile" }

M.opts = {
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
    },
    signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
    },
}

vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")

return M
