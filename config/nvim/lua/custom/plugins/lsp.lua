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
        opts = {},
        config = function ()
            require("fidget").setup({
                text = {
                    spinner = 'moon'
                },
                window = {
                    blend = 0
                },
            })
        end
    },
    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    'VonHeikemen/lsp-zero.nvim',
}

function Plugin.config()
    local lsp = require("lsp-zero")

    lsp.preset("recommended")

    local signs={
        Error = '✘',
        Warn = '▲',
        Hint = '⚑',
        Info = '»'
    }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    lsp.on_attach(function(client, bufnr)
        local keybind = vim.keymap.set
        local opts = {buffer = bufnr, remap = false}
        keybind("n", "gd", function() vim.lsp.buf.definition() end, opts)
        keybind("n", "K", function() vim.lsp.buf.hover() end, opts)
        keybind("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        keybind("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        keybind("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        keybind("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
        keybind("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        keybind("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        lsp.default_keymaps({buffer = bufnr})
    end)

    vim.diagnostic.config({
        virtual_text = true
    })

    require('neodev').setup()
    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = {'lua_ls','pyright','texlab'},
        handlers = {
            lsp.default_setup,
        },
    })

end

return Plugin
