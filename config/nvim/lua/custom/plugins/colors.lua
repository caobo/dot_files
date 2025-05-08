local function color_setting(color_name)
    -- set color variant
    local setting = string.format("colorscheme %s", color_name)
    vim.cmd(setting)

    -- background transparency
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })
end

local M_rose = { "rose-pine/neovim" }
local M_catppuccin = { "catppuccin/nvim" }

M_rose.event = { 'BufReadPost', 'BufNewFile' }
M_catppuccin.event = { 'BufReadPost', 'BufNewFile' }

M_rose.name = 'rose-pine'
M_catppuccin.name = 'catppuccin'

function M_rose.config()
    local rose = require("rose-pine")
    rose.setup({
        variant = "main",      -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
            terminal = true,
            legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
            migrations = true,         -- Handle deprecated options automatically
        },

        styles = {
            bold = true,
            italic = true,
            transparency = true,
        },

        groups = {
            border = "muted",
            link = "iris",
            panel = "surface",

            error = "love",
            hint = "iris",
            info = "foam",
            note = "pine",
            todo = "rose",
            warn = "gold",

            git_add = "foam",
            git_change = "rose",
            git_delete = "love",
            git_dirty = "rose",
            git_ignore = "muted",
            git_merge = "iris",
            git_rename = "pine",
            git_stage = "iris",
            git_text = "rose",
            git_untracked = "subtle",

            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
        },

        palette = {
            -- Override the builtin palette per variant
            -- moon = {
            --     base = '#18191a',
            --     overlay = '#363738',
            -- },
        },

        highlight_groups = {
            -- Comment = { fg = "foam" },
            VertSplit = { fg = "muted", bg = "muted" },
            CurSearch = { fg = "base", bg = "leaf", inherit = false },
            Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
            StatusLine = { fg = "love", bg = "love", blend = 10 },
            StatusLineNC = { fg = "subtle", bg = "surface" },
        },

        before_highlight = function(group, highlight, palette)
            _ = group
            if highlight.fg == palette.pine then
                highlight.fg = palette.love
            end
        end,
    })

    color_setting("rose-pine")
end

function M_catppuccin.config()
    require('catppuccin').setup {
        flavour = "mocha",             -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
        no_italic = false,             -- Force no italic
        no_bold = false,               -- Force no bold
        no_underline = false,          -- Force no underline
        integrations = {
            blink_cmp = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                    ok = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                    ok = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            which_key = true
        },
        styles = {
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = { "altfont" },
            keywords = { "bold", "italic" },
            strings = {},
            variables = { "italic" },
            numbers = { "bold" },
            booleans = { "italic" },
        },
        custom_highlights = function(colors)
            return {
                LineNr = { fg = colors.overlay2 },
            }
        end,
    }

    color_setting("catppuccin")
end

_ = M_rose
_ = M_catppuccin

return M_rose

