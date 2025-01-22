local function color_setting(color_name)
    -- set color variant
    local setting = string.format("colorscheme %s", color_name)
    vim.cmd(setting)

    -- background transparency
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })
end

local M_rose = { "rose-pine/neovim" }
local M_tokyo = { "folke/tokyonight.nvim" }
local M_mellow = { "mellow-theme/mellow.nvim" }
local M_oldworld = { "dgox16/oldworld.nvim" }

M_rose.event = { 'BufReadPost', 'BufNewFile' }
M_tokyo.event = { 'BufReadPost', 'BufNewFile' }
M_mellow.event = { 'BufReadPost', 'BufNewFile' }
M_oldworld.event = { 'BufReadPost', 'BufNewFile' }

M_rose.name = 'rose-pine'

function M_rose.config()
    local rose = require("rose-pine")
    rose.setup({
        variant = "auto",      -- auto, main, moon, or dawn
        dark_variant = "moon", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
            terminal = true,
            legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
            migrations = true,        -- Handle deprecated options automatically
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
            -- VertSplit = { fg = "muted", bg = "muted" },
            CurSearch = { fg = "base", bg = "leaf", inherit = false },
            Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
            StatusLine = { fg = "love", bg = "love", blend = 10 },
            StatusLineNC = { fg = "subtle", bg = "surface" },
            -- telescope setting
            TelescopeBorder = { fg = "highlight_high", bg = "none" },
            TelescopeNormal = { bg = "none" },
            TelescopeResultsNormal = { fg = "subtle", bg = "none" },
            TelescopeSelection = { fg = "text", bg = "none" },
            TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
            TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
            TelescopeTitle = { fg = "base", bg = "love" },
            TelescopePromptTitle = { fg = "base", bg = "foam" },
            TelescopePreviewTitle = { fg = "base", bg = "iris" },
            TelescopePromptNormal = { fg = "text", bg = "surface" },
            TelescopePromptBorder = { fg = "surface", bg = "surface" },
        },

        before_highlight = function(group, highlight, palette)
            -- _ = group
            -- Disable all undercurls
            -- if highlight.undercurl then
            --     highlight.undercurl = false
            -- end
            --
            -- Change palette colour
            if highlight.fg == palette.pine then
                highlight.fg = palette.love
            end
        end,
    })

    color_setting("rose-pine-moon")
end

function M_tokyo.config()
    color_setting("tokyonight-moon")
end

function M_mellow.config()
    color_setting("mellow")
end

function M_oldworld.config()
    color_setting("oldworld")
end

_ = M_rose
_ = M_tokyo
_ = M_mellow
_ = M_oldworld

return M_rose
