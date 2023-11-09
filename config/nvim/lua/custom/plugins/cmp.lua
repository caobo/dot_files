local Plugin = {"hrsh7th/nvim-cmp"}
Plugin.event = { "InsertEnter", "CmdlineEnter" }

Plugin.dependencies = {
    "hrsh7th/cmp-buffer", -- Buffer Completions
    "hrsh7th/cmp-path", -- Path Completions
    "saadparwaiz1/cmp_luasnip", -- Snippet Completions
    "hrsh7th/cmp-nvim-lsp", -- LSP Completions
    "hrsh7th/cmp-nvim-lua", -- Lua Completions
    "hrsh7th/cmp-cmdline", -- CommandLine Completions
}

function Plugin.config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local function border(hl_name)
        return {
            { "●", hl_name }, -- left top
            { "─", hl_name },
            { "●", hl_name }, -- right top
            { "│", hl_name },
            { "●", hl_name }, -- right bottom
            { "─", hl_name },
            { "●", hl_name }, -- left bottom
            { "│", hl_name },
        }
    end

    cmp.setup({

        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },

        mapping = cmp.mapping.preset.insert {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1)),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1)),
            -- ["<C-y>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-e>"] = cmp.mapping {
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            },
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            --
            ["<CR>"] = cmp.mapping.confirm { select = false },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
        "i",
        "s",
    }),
},

formatting = {
    fields = {'menu', 'abbr', 'kind'},
},

sources = {
    {
        name = "path",
        option = {
            trailing_slash = true
        }

    },
    { name = "nvim_lsp", keyword_lengt=3},
    { name = "buffer", keyword_length = 3},
    { name = "luasnip", keyword_length = 2},
},

confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
},

window = {
    completion = cmp.config.window.bordered {
        -- border = "rounded",
        border = border "CmpBorder",
        -- winhighlight = "Normal:Normal,FloatBorder:CmpCompletionBorder,CursorLine:CmpCursorLine,Search:Search",
        max_height = 20,
        max_width = 100,
        zindex = 50,
        col_offset = -3,
        side_padding = 1,
    },
    documentation = cmp.config.window.bordered {
        -- border = "rounded",
        border = border "CmpBorder",
        -- winhighlight = "Normal:Normal,FloatBorder:CmpDocumentationBorder,CursorLine:CmpCursorLine,Search:Search",
        max_height = 20,
        max_width = 100,
        zindex = 50,
        col_offset = -3,
        side_padding = 1,
    },
},

experimental = {
    ghost_text = true,
},
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    require('lspconfig').lua_ls.setup {
        capabilities = capabilities
    }
    require('lspconfig').texlab.setup {
        capabilities = capabilities
    }
    require('lspconfig').pyright.setup {
        capabilities = capabilities
    }

end

return Plugin
