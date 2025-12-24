local M = { 'nvim-treesitter/nvim-treesitter' }
M.build = ":TSUpdate"
M.event = { 'BufReadPre', 'BufNewFile' }
M.cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" }

M.dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
}

M.opts_extend = { "ensure_installed" }
---@type TSConfig
---@diagnostic disable-next-line: missing-fields
M.opts = {
    highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = { 'html', 'html.twig', 'vimdoc' },
        additional_vim_regex_highlighting = false
    },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'ga',
            node_incremental = 'ga',
            node_decremental = 'gz',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['ia'] = '@parameter.inner',
            }
        },
        swap = {
            enable = true,
            swap_previous = {
                ['{a'] = '@parameter.inner',
            },
            swap_next = {
                ['}a'] = '@parameter.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']f'] = '@function.outer',
                [']c'] = '@class.outer',
                [']a'] = '@parameter.inner',
            },
            goto_next_end = {
                [']F'] = '@function.outer',
                [']C'] = '@class.outer',
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[c'] = '@class.outer',
                ['[a'] = '@parameter.inner',
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[C'] = '@class.outer',
            },
        },
    },
    ensure_installed = {
        'bash',
        'bibtex',
        'c',
        'comment',
        'cpp',
        'css',
        'dot',
        'gitignore',
        'go',
        'html',
        'latex',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'rust',
        'vim',
        'vimdoc',
    },
}

function M.config(_, opts)
    require('nvim-treesitter.configs').setup(opts)
end

return M
