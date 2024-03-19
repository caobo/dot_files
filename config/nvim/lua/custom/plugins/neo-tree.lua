local M = {"nvim-neo-tree/neo-tree.nvim"}

M.branch = "v3.x"
M.dependencies = {
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
function M.config ()

end

vim.keymap.set("n","<leader>e","<cmd>Neotree toggle position=float<cr>")

return M
