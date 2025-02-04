local M = {'yamatsum/nvim-cursorline'}
-- M.event ={ 'BufReadPost', 'BufNewFile'}

function M.config()
    local cursorline = require("nvim-cursorline")
    cursorline.setup({
        cursorline = {
            enable = false,
            timeout = 1000,
            number = false,
        },
        cursorword = {
            enable = true,
            min_length = 1,
            hl = { underline = true },
        },
    })
end

return M
