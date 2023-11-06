return{
    'VonHeikemen/lsp-zero.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        {
            'neovim/nvim-lspconfig',
            event = { 'BufReadPre', 'BufNewFile' },
        },
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {} },
        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },
}
