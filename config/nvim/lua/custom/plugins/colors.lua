local function color_setting(color_name)
    -- set color variant
    local setting = string.format("colorscheme %s", color_name)
    -- background transparency
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })

    vim.cmd(setting)
end

local function color_select(color_table)
    local repo, opts, name = color_table[1], color_table[2], color_table[3]
    local setting = { string.format("%s", repo) }
    setting.event = { 'BufReadPost', 'BufNewFile' }
    setting.name = name
    setting.config = function ()
        opts()
    end
    return setting
end

local rose_opts = function ()
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
            -- main = {
            -- base = '#000000',
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

local catppuccin_opts = function ()
    require('catppuccin').setup {
        flavour = "mocha",             -- latte, frappe, macchiato, mocha
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
        no_italic = false,             -- Force no italic
        no_bold = false,               -- Force no bold
        no_underline = false,          -- Force no underline

        integrations = {
            blink_cmp = true,
            fzf = true,
            gitsigns = true,
            indent_blankline = { enabled = true },
            treesitter = true,
            treesitter_context = true,
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
        color_overrides = {
            all = {
                rosewater = '#f65151',
                flamingo = '#d2ccff',
                pink = '#ffc4c4',
                mauve = '#ffabca',
                red = '#edabab',
                maroon = '#f66181',
                peach = '#ffd3ac',
                yellow = '#eecfa0',
                green = '#a0ffaf',
                teal = '#a1e8e5',
                sky = '#8fc7ff',
                sapphire = '#8fc7ff',
                blue = '#8fc7ff',
                lavender = '#ebe5ff',
                text = '#ffffff',
                subtext1 = '#deddda',
                subtext0 = '#c0bfbc',
                overlay2 = '#858585',
                overlay1 = '#737373',
                overlay0 = '#616161',
                surface2 = '#4f4f4f',
                surface1 = '#3e3e3e',
                surface0 = '#2e2e2e',
                base = '#1E1E1E',
                mantle = '#1A1A1A',
                crust = '#101010'
            }
        }
    }
    color_setting("catppuccin")
end

local rose_theme = { "rose-pine/neovim", rose_opts, "rose" }
local catppuccin_theme = { "catppuccin/nvim", catppuccin_opts, "catppuccin"}

_ = rose_theme
_ = catppuccin_theme

local M = color_select(catppuccin_theme)
return M
