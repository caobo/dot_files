local M = { 'MeanderingProgrammer/markdown.nvim' }
M.dependencies = { 'nvim-treesitter/nvim-treesitter' }

M.ft = { 'markdown' }

M.config = function()
    require('render-markdown').setup({})
end

return M
