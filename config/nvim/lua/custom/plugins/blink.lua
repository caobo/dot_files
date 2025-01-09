local M = {'saghen/blink.cmp'}
---@module 'blink.cmp'
---@type blink.cmp.Config
M.event = {"CmdlineEnter", "BufReadPost",  "BufNewFile"}
M.version = '*'

function M.config ()

    local blink = require("blink.cmp")

    blink.setup({

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
        default = { 'lsp','snippets', 'path', 'buffer' },
    },

    completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
            auto_show = true,
            border = 'rounded',
            scrollbar = false,
            draw = {
                columns = { { 'item_idx' }, { 'kind_icon' }, {'kind', gap = 10}, { 'label', 'label_description', gap = 3 } },
                components = {
                    item_idx = {
                        text = function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx) end,
                        highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
                    }
                },
            },
        },
        documentation = {
            auto_show_delay_ms = 0,
            auto_show = true,
            window = {border = 'rounded'},
        },
        ghost_text = { enabled = true }
    },

    signature = {
        enabled = true,
        window = { border = 'rounded' }
    },

})
end

M.opts_extend = { "sources.default" }

return M
