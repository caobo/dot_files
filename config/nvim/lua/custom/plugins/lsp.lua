local M = { 'neovim/nvim-lspconfig' }

M.event = { 'BufReadPre', 'BufNewFile' }
M.cmd = "Mason"

M.dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    {
        'j-hui/fidget.nvim',
        opts = {},
    },
    -- Additional lua configuration, makes nvim stuff amazing!
}

function M.config()

    -- installed lsp servers
    local lsp_servers = { 'lua_ls', 'texlab', 'pyright', 'bashls', 'clangd', 'rust_analyzer', 'gopls' }

    vim.lsp.config('lua_sl',
        {
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
        }
    )

    vim.lsp.config('texlab',
        {
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
        }
    )

    for _, server in ipairs(lsp_servers) do
        vim.lsp.enable(server)
    end


    require('lazydev').setup()

    require('mason').setup()

    -- ask mason to install linters and formatters
    vim.list_extend(lsp_servers,
        {
            -- 'tex-fmt',
        }
    )

    require('mason-lspconfig').setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,
        automatic_enable = false,
    })
end

return M
