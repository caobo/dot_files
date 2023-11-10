local Plugin = {'neovim/nvim-lspconfig'}

Plugin.lazy = "VeryLazy"
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
        opts = {
            text = {
                -- spinner = 'moon'
                spinner = 'dots_pulse'
            }
        },
    },
    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
}

function Plugin.config()

    local lspconfig = require('lspconfig')

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

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local keybind = vim.keymap.set
            local opts = {buffer = event.buf,remap = false}
            keybind("n", "gd", function() vim.lsp.buf.definition() end, opts)
            keybind("n", "K", function() vim.lsp.buf.hover() end, opts)
            keybind("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            keybind("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            keybind("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            keybind("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
            keybind("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
            keybind("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end
    })

    require('neodev').setup()
    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = {"lua_ls","pyright","texlab"},
        handlers = {
            -- default_setup,
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        }
    })

end

return Plugin
