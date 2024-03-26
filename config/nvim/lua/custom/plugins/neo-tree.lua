local M = {"nvim-neo-tree/neo-tree.nvim"}

M.branch = "v3.x"

M.dependencies = {
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
}

M.keys = {
    { "<leader>e", "<cmd>Neotree toggle position=float<cr>", desc = "NeoTree" },
}

function M.config ()
    require("neo-tree").setup{
        window = {
            mappings = {
                ["<space>"] = "open"
            }
        }
    }
end

return M
