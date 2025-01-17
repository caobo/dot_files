local M ={"jiaoshijie/undotree"}

M.dependencies = "nvim-lua/plenary.nvim"

M.keys = {
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
}

function M.config()
    local undotree = require("undotree")
    undotree.setup( {
        config = true,
        float_diff = true,
    })
end


return M
