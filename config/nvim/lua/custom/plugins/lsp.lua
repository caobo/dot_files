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
    local lsp_servers = { 'lua_ls', 'texlab', 'pyright', 'bashls', 'clangd', 'rust_analyzer', 'gopls' }

    for _, server in ipairs(lsp_servers) do
        require('lspconfig')[server].setup {}
        -- vim.lsp.enable(server)
    end

    require('lazydev').setup()

    require('mason').setup()

    vim.list_extend(lsp_servers,
        {
            -- 'tex-fmt',
        }
    )

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
            }),
            lspconfig.texlab.setup({
                settings = {
                    texlab = {
                        build = {
                            args = {},
                            onSave = true,
                        },
                        chktex = {
                            onEdit = true,
                            onOpenAndSave = true,
                        },
                        latexindent = {
                            args = { '-l' },
                        },
                    },
                }
            })
        }
    })
end

return M
