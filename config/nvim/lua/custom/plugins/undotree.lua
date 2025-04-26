local M = { "y3owk1n/time-machine.nvim" }

M.version = "*"

M.keys = {
    {
        "<leader>u",
        function()
            require("time-machine").actions.toggle()
        end,
        mode = "n",
        desc = "[Time Machine] Toggle Tree",
    },
}

---@type TimeMachine.Config
M.opts = {}

return M
