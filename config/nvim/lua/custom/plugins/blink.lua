local M = { 'saghen/blink.cmp' }
M.version = '*'
M.event = { 'InsertEnter' }

M.opts_extend = {
    "sources.completion.enabled_providers",
    "sources.default",
}

---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {

    keymap = { preset = 'default' },

    appearance = {
        highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono'
    },

    snippets = {
        preset = "luasnip",
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
            if filter and filter.direction then
                return require('luasnip').jumpable(filter.direction)
            end
            return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
    },

    sources = {
        default = { 'lsp', 'snippets', 'path', 'buffer', 'lazydev' },
        per_filetype = {
            -- optionally inherit from the `default` sources
            lua = { inherit_defaults = true, 'lazydev' }
        },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100, -- show at a higher priority than lsp
            },
        },
    },

    completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
            auto_show = true,
            border = 'rounded',
            scrollbar = false,
            draw = {
                treesitter = { 'lsp' },
                columns = { { 'kind_icon', 'kind', gap = 2 }, { 'label', 'label_description', gap = 2 }, { "source_name", gap = 2 } },
            },
        },
        documentation = {
            treesitter_highlighting = true,
            auto_show_delay_ms = 200,
            auto_show = true,
            window = { border = 'rounded' },
        },
        ghost_text = { enabled = true }
    },

    signature = {
        enabled = true,
        window = {
            border = 'rounded',
            treesitter_highlighting = true,
        },
    },

    fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
            'score',     -- Primary sort: by fuzzy matching score
            'sort_text', -- Secondary sort: by sortText field if scores are equal
            'label',     -- Tertiary sort: by label if still tied
        }
    },
}

return M
