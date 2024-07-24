local M = {'neovim/nvim-lspconfig'}

M.event ={ 'BufReadPost', 'BufNewFile'}
M.dependencies={
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
        'j-hui/fidget.nvim',
        event = "LspAttach",
        opts = {},
    },
    -- Additional lua configuration, makes nvim stuff amazing!
}

function M.config()

    local lspconfig = require('lspconfig')

    local signs={
        -- Error = '✘',
        -- Warn = '▲',
        -- Hint = '⚑',
        -- Info = '»'
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
    }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local map = vim.keymap.set
            local opts = {buffer = event.buf,remap = false}
            map("n", "gd", function() vim.lsp.buf.definition() end, opts)
            map("n", "K", function() vim.lsp.buf.hover() end, opts)
            map("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            map("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            map("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
            map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
            map("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end
    })

    require('lazydev').setup()

    require('mason').setup()

    local ensure_installed = {"lua_ls","pyright","texlab","tsserver","gopls","rust_analyzer","clangd"}

    require('mason-lspconfig').setup({
        ensure_installed = ensure_installed,
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

return M
