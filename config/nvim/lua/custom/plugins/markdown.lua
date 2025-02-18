local M = { 'MeanderingProgrammer/markdown.nvim' }
M.dependencies = { 'nvim-treesitter/nvim-treesitter' }

M.ft = { 'markdown' }

M.config = function()
    require('render-markdown').setup({
        heading = {
            width = 'block'
        },
        code = {
            width = "block",
        },
        checkbox = {
            checked = { scope_highlight = "@markup.strikethrough" },
            custom = {
                todo = { raw = "", rendered = "", highlight = "" },
                canceled = {
                    raw = "[-]",
                    rendered = "󱘹",
                    scope_highlight = "@markup.strikethrough",
                },
            },
        },
    })
end

return M
