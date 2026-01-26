local M = { "jiaoshijie/undotree" }

M.keys = { -- load the plugin only when using it's keybinding:
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
}

M.opts = {
}

return M
