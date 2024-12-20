local M = {'saghen/blink.cmp'}

M.event = {"CmdlineEnter", "BufReadPost",  "BufNewFile"}
M.version = 'v0.*'

M.opts_extend = { "sources.default" }

function M.config ()
    local blink = require("blink.cmp")

    blink.setup({
    keymap = { preset = 'default' },

    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono'
    },

    snippets = {
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
        default = { 'luasnip', 'lsp', 'path', 'buffer' },
        -- optionally disable cmdline completions
        cmdline = {},
        completion = {
          enabled_providers = { "lsp", "path", "luasnip", "buffer", "lazydev" },
        },
        providers = {
            lsp = { fallback_for = { "lazydev" } },
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        }
    },

    completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
            border = vim.g.border_style, scrolloff = 1,
            scrollbar = false,
            columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
        },
        documentation = {
          auto_show_delay_ms = 0,
          auto_show = true,
          window = {border = vim.g.border_style},
        },
      },

    signature = {
        enabled = true,
        border = vim.g.border_style,
    },

})
end

return M
