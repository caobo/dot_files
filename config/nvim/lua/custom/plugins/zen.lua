local M = { "folke/zen-mode.nvim" }

M.cmd = { "ZenMode" }

M.config = function()
    require("zen-mode").toggle({
        window = {
            width = .85 -- width will be 85% of the editor width
        }
    })
end

_ = M

return M
