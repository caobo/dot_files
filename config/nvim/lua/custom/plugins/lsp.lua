local Plugin = {'neovim/nvim-lspconfig'}

Plugin.lazy = true
Plugin.dependencies={
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
        'j-hui/fidget.nvim',
        tag = "legacy",
        event = "LspAttach",
        opts = {}
    },
    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    'VonHeikemen/lsp-zero.nvim',
}

function Plugin.config()
    local lsp = require("lsp-zero")

    require('fidget').setup({
        text = {
            spinner = 'moon'
        },
        window = {
            blend = 0
        },
    })

    lsp.preset("recommended")

    lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        }
    })

    lsp.on_attach(function(client, bufnr)
        local keybind = vim.keymap.set
        local opts = {buffer = bufnr, remap = false}
        local telescope = require('telescope.builtin')
        keybind("n", "gd", function() vim.lsp.buf.definition() end, opts)
        keybind("n", "K", function() vim.lsp.buf.hover() end, opts)
        keybind("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        keybind("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        keybind("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        keybind("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        keybind("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        keybind("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
        keybind("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        keybind("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        keybind('n', '<leader>fd', telescope.lsp_document_symbols, opts)
        keybind('n', '<leader>fq', telescope.lsp_workspace_symbols, opts)
        lsp.default_keymaps({buffer = bufnr})
    end)

    vim.diagnostic.config({
        virtual_text = true
    })

    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = {'lua_ls','pyright','texlab'},
        handlers = {
            lsp.default_setup,
        },
    })

end

return Plugin
