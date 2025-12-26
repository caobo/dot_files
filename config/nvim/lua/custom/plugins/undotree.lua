local M = { "jiaoshijie/undotree" }

M.keys = { -- load the plugin only when using it's keybinding:
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
}

---@module 'undotree.collector'
---@type UndoTreeCollector.Opts
M.opts = {
    -- your options
}

return M
