local M = { 'neovim/nvim-lspconfig' }

M.event = { 'BufReadPre', 'BufNewFile' }
M.cmd = "Mason"

M.dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
        'j-hui/fidget.nvim',
        opts = {},
    },
    -- Additional lua configuration, makes nvim stuff amazing!
}

function M.config()
    local lspconfig = require('lspconfig')

    -- installed lsp servers
    local lsp_servers = { 'lua_ls', 'texlab', 'pyright', 'ts_ls', 'clangd', 'rust_analyzer', 'gopls' }

    -- set capabilities for each lsp server
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    for _, server in ipairs(lsp_servers) do
        require('lspconfig')[server].setup { capabilities = capabilities }
    end

    local signs = {
        Error = '✘',
        Warn = "ⓘ ",
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
            local opts = { buffer = event.buf, remap = false }
            map("n", "gd", function() vim.lsp.buf.definition() end, {desc="Goto definition (lsp)",unpack(opts)})
            map("n", "K", function() vim.lsp.buf.hover() end, {desc="Help information (lsp)", unpack(opts)})
            map("n", "[d", function() vim.diagnostic.goto_prev() end, {desc="Prev diagnostic", unpack(opts)})
            map("n", "]d", function() vim.diagnostic.goto_next() end, {desc="Next diagnostics", unpack(opts)})
            map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, {desc="Code action (lsp)", unpack(opts)})
            map("n", "<leader>rr", function() vim.lsp.buf.references() end, {desc="references open in quickfix list (lsp)", unpack(opts)})
            map("n", "<leader>rn", function() vim.lsp.buf.rename() end, {desc="rename (lsp)", unpack(opts)})
            map("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {desc="signature help (lsp)", unpack(opts)})
        end
    })

    lspconfig.diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "icons",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = "WarningMsg",
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
        },
    }

    lspconfig.inlay_hints = {
        enabled = true,
    }

    require('lazydev').setup()

    require('mason').setup()

    require('mason-lspconfig').setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,
        handlers = {
            -- default_setup,
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' },
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
