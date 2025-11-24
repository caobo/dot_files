local M = { 'A7Lavinraj/fyler.nvim' }

M.cmd = 'Fyler '

M.keys = {
    { '-', '<cmd>Fyler kind=float<CR>', { desc = 'Open fyler' } }
}

function M.config()
    require('fyler').setup({
        integrations = {
            icon = "mini_icons",
        },
        -- default_file_explorer = true,
        indentscope = {
            enabled = true,
            group = "FylerIndentMarker",
            marker = "│",
        },
        mappings = {
            ["q"] = "CloseView",
            ["<CR>"] = "Select",
            ["<C-t>"] = "SelectTab",
            ["|"] = "SelectVSplit",
            ["-"] = "SelectSplit",
            ["^"] = "GotoParent",
            ["="] = "GotoCwd",
            ["."] = "GotoNode",
            ["#"] = "CollapseAll",
            ["<BS>"] = "CollapseNode",
        },
    })
end

return M
