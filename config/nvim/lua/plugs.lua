-- [[ plug.lua ]]

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
--
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--  You can also configure plugins after the setup call,
--  as they will be available in your neovim runtime.
--
require('lazy').setup({
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    -- {'tpope/vim-fugitive', lazy = true},

    -- {'tpope/vim-rhubarb', lazy = true},

    -- Detect tabstop and shiftwidth automatically
    {'tpope/vim-sleuth', lazy = true},

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },

    -- Useful plugin to show you pending keybinds.
    {'folke/which-key.nvim', event = "VeryLazy", opts = {}},

    { -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '*' },
                delete = { text = '-' },
                topdelete = { text = '‾' },
                changedelete = { text = '*-' },
            }
        }
    },

    { -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            }
        }
    },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        -- event = "InsertEnter",
        opts = {}
    },

    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim', --[[ version = '*', ]]
        dependencies = {
            'nvim-lua/plenary.nvim','nvim-telescope/telescope-file-browser.nvim'
        }
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    },

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            init = function()
                -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                local plugin = require('lazy.core.config').spec.plugins['nvim-treesitter']
                local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
                local enabled = false
                if opts.textobjects then
                    for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
                        if opts.textobjects[mod] and opts.textobjects[mod].enable then
                            enabled = true
                            break
                        end
                    end
                end
                if not enabled then
                    require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
                end
            end,
        },
        -- config = function()
        --     pcall(require('nvim-treesitter.install').update { with_sync = true })
        -- end
    },

    {'HiPhish/nvim-ts-rainbow2', event ={'BufReadPost', 'BufNewFile'}},

    {
        -- rose-pine color theme
        'rose-pine/neovim',
        event ={'BufReadPost', 'BufNewFile'},
        name = 'rose-pine',
    },

    {
        --     -- github color theme
        -- 'projekt0n/github-nvim-theme',
        -- event ={'BufReadPost', 'BufNewFile'}
    },

    {
        'kylechui/nvim-surround',
        event ={ 'BufReadPost', 'BufNewFile'},
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- {
    --     'kdheepak/tabline.nvim',
    --     event ={ 'BufReadPost', 'BufNewFile'},
    --     config = true,
    -- },

    {
        'folke/trouble.nvim',
        -- event = 'VeryLazy',
        event ={ 'BufReadPost', 'BufNewFile'},
        cmd = { 'TroubleToggle', 'Trouble' },
        opts = { use_diagnostic_signs = true },
        dependencies ={ 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' },
        config = function()
            require('trouble').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',
                    -- {silent = true, noremap = true}),
                vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
                    {silent = true, noremap = true}),
                vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',
                    {silent = true, noremap = true}),
                -- refer to the configuration section below
            }
        end
    },

    {
        "L3MON4D3/LuaSnip", -- Snippet Engine
        event ={ 'BufReadPost', 'BufNewFile'},
    },

    {
        "windwp/nvim-autopairs",
        event ={ 'BufReadPost', 'BufNewFile'},
        -- event = "InsertEnter",
        config = function()
            local autopairs = require "nvim-autopairs"

            autopairs.setup {
                check_ts = true, -- treesitter integration
                disable_filetype = { "TelescopePrompt" },
            }

            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if not cmp_status_ok then
                return
            end
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
        end,
    },

    {'yamatsum/nvim-cursorline',
        event ={ 'BufReadPost', 'BufNewFile'}
    },
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    --    additional installs are in following directory.
    { import = 'custom/plugins' },
})
