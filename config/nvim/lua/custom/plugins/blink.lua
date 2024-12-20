local M = {'saghen/blink.cmp'}

M.event = {"CmdlineEnter", "BufReadPost",  "BufNewFile"}
M.version = 'v0.*'

function M.config ()
    local blink = require("blink.cmp")

    blink.setup({
    keymap = { preset = 'default' },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
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
      default = { 'lsp', 'path', 'luasnipe', 'snippets', 'buffer' },
      -- optionally disable cmdline completions
      -- cmdline = {},
    },

    signature = { enabled = true }

})
end

M.opts_extend = { "sources.default" }

return {}
