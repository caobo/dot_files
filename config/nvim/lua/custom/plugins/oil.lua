local M ={'stevearc/oil.nvim'}

function M.config()
    require('oil').setup(
        {

            default_file_explorer = true,

            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },

            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = true,
            watch_for_changes = true,
            cleanup_delay_ms = 2000,

            lsp_file_methods = {
                -- Enable or disable LSP file operations
                enabled = true,
                -- Time to wait for LSP file operations to complete before skipping
                timeout_ms = 1000,
                -- Set to true to autosave buffers that are updated with LSP willRenameFiles
                -- Set to "unmodified" to only save unmodified buffers
                autosave_changes = false,
            },

            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<C-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = true,

            view_options = {
                natural_order = "fast",
                sort = {
                    -- sort order can be "asc" or "desc"
                    -- see :help oil-columns to see which columns are sortable
                    { "type", "asc" },
                    { "name", "asc" },
                },
            },

            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = 100,
                max_height =30,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
                -- get_win_title = nil,
                -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                preview_split = "auto",
            },

            preview_win = {
                -- Whether the preview window is automatically updated when the cursor is moved
                update_on_cursor_moved = true,
                -- How to open the preview window "load"|"scratch"|"fast_scratch"
                preview_method = "fast_scratch",
                -- A function that returns true to disable preview on a file e.g. to avoid lag
            },

    })

    vim.keymap.set('n', '-', '<cmd>Oil --float<cr>', {noremap = true, silent = true})

end
return M
