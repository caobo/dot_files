local M = { "ibhagwan/fzf-lua" }

M.dependencies = { "echasnovski/mini.icons" }

M.cmd = 'Fzflua'

M.keys = {
    -- find
    { "<leader>/",       "<cmd>FzfLua builtin<cr>",                                  desc = "All Pickers" },
    { "<leader><space>", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>fp",      "<cmd>FzfLua git_files<cr>",                                desc = "Find Files (git-files)" },
    { "<leader>ff",      "<cmd>FzfLua files<cr>",                                    desc = "Find Files (current directory)" },
    { "<leader>fh",      "<cmd>FzfLua oldfiles<cr>",                                 desc = "Recent" },
    -- search
    { "<leader>fw",      "<cmd>FzfLua grep_curbuf<cr>",                              desc = "Buffer" },
    { "<leader>fg",      "<cmd>FzfLua grep_cword<cr>",                               desc = "Search Word under cursor" },
    { "<leader>sh",      "<cmd>FzfLua help_tags<cr>",                                desc = "Help Pages" },
    { "<leader>fW",      "<cmd>FzfLua live_grep_native<cr>",                         desc = "Find Word using live grep" },
    { "<leader>fd",      "<cmd>FzfLua lsp_document_symbols<cr>",                     desc = "Document symbols" },
    { "<leader>sp",      "<cmd>FzfLua spell_suggest<cr>",                            desc = "Spell Check" }
}

function M.config()
    local fzf = require("fzf-lua")

    fzf.config.defaults.keymap = {
        fzf = {
            ["ctrl-q"] = "accept",
            ["ctrl-Q"] = "select-all+accept",
            ["ctrl-u"] = "half-page-up",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-x"] = "jump",
            ["ctrl-f"] = "preview-page-down",
            ["ctrl-b"] = "preview-page-up",
        },
        builtin = {
            ["<c-f>"] = "preview-page-down",
            ["<c-b>"] = "preview-page-up",
        }
    }
    fzf.config.defaults.formatter = "path.dirname_first"
    fzf.config.fzf_colors = true

    local function default_view(title, preview)
        return {
            winopts = {
                height   = 0.9, -- Taller window for oldfiles
                width    = 0.8, -- Wider window
                backdrop = 100,
                title    = title,
                preview  = { -- Preview settings
                    border = 'rounded',
                    show_preview_title = true,
                    hidden = not preview,
                    vertical = 'up:45%', -- Preview above (45% height)
                    horizontal = 'right:60%',
                }
            }
        }
    end

    local function item_view(title)
        return {
            previewer = false,
            winopts = {
                backdrop = 100,
                title = title,
                height = 0.5,
                width = 0.5,
            }
        }
    end

    fzf.setup {
        git = { files = default_view("Find fless in project", true) },
        files = item_view("Find fless in pwd"),
        oldfiles = default_view("Recent files", true),
        buffers = item_view("Open buffers"),
        grep_curbuf = default_view("Grep Word in current buffer", false),
        live_grep_native = default_view("Grep in Project", true),
        grep_cword = default_view("Search", true),
        help_tags = default_view("Help pages", true),
        lsp_document_symbols = default_view("LSP symbols", true),
        spell_suggest = item_view("Spell suggestions"),
        builtin = item_view("Builtin pickers")
    }
end

return M
