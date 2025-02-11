local M = { 'saghen/blink.cmp' }
M.version = '*'
M.event = { "InsertEnter" }

---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {

    keymap = { preset = 'default' },

    appearance = {
        use_nvim_cmp_as_default = true,
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
        default = { 'lsp', 'snippets', 'path', 'buffer' },
    },

    completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
            auto_show = true,
            border = 'rounded',
            scrollbar = false,
            draw = {
                treesitter = { 'lsp' },
                columns = { { 'kind_icon' }, { 'kind', gap = 5 }, { 'label', 'label_description' } },
            },
        },
        documentation = {
            auto_show_delay_ms = 0,
            auto_show = true,
            window = { border = 'rounded' },
        },
        ghost_text = { enabled = true }
    },

    signature = {
        enabled = true,
        window = { border = 'rounded' }
    },
}

M.opts_extend = { "sources.default" }

return M
