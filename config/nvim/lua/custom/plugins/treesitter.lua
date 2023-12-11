local M = {'nvim-treesitter/nvim-treesitter'}
M.pin = true
M.build = ":TSUpdate"
M.event = {'BufReadPost', 'BufNewFile'}

M.dependencies = {
    {'nvim-treesitter/nvim-treesitter-textobjects', pin = true},
}

M.opts = {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {'html', 'html.twig', 'vimdoc'},
    },
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
        'c',
        'cpp',
        'lua',
        'python',
        'rust',
        'vim',
        'bibtex',
        'latex',
        'markdown',
        'markdown_inline',
        'css',
        'dot',
        'gitignore',
        'javascript',
        'bash',
        "luadoc",
        "regex",
        "html",
        "vimdoc",
        "comment",
    },
}

function M.build()
    pcall(vim.cmd, 'TSUpdate')
end

function M.config(_, opts)
    require('nvim-treesitter.configs').setup(opts)
end

return M
