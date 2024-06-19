local M = {'nvim-lualine/lualine.nvim'}

M.event = { 'BufReadPost', 'BufNewFile' }

function M.config()

    -- cool function for progress
    local progress = function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
    end

    -- show attached lsp server name
    local lsp_info = function()
        local buf_type = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if not next(clients) then
            return 'No active LSP server'
        end
        for _, client in ipairs(clients) do
            local lsp_filetypes = client.config.filetypes
            if lsp_filetypes and vim.tbl_contains(lsp_filetypes, buf_type) then
                return string.format("LSP server: [%s]", client.name)
            end
        end
        return nil
    end

    local lualine = require("lualine")

    lualine.setup({
        options = {
            -- theme = "nightfly",
            icons_enabled = true,
            disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
            component_separators = " ",
            section_separators = { left = ' ', right = ' ' },
        },
        sections = {
            lualine_a = {
                {
                    "mode", separator = { left = '▊' }, right_padding = 0
                }
            },
            lualine_b = {
                'filename',
                "filesize",
                "branch",
                'diagnostics',
                {
                    "diff", colored = true
                }
            },
            lualine_c = {
                '%=',
                {
                    "searchcount", draw_empty = true
                },
                {
                    "selectioncount", draw_empty = true
                },
                {
                    'buffers',
                    show_filename_only = true,   -- Shows shortened relative path when set to false.
                    hide_filename_extension = false,   -- Hide filename extension when set to true.
                    show_modified_status = true, -- Shows indicator when the buffer is modified.
                    mode = 1,
                    -- 0: Shows buffer name
                    -- 1: Shows buffer index
                    -- 2: Shows buffer name + buffer index
                    -- 3: Shows buffer number
                    -- 4: Shows buffer name + buffer number
                },
                lsp_info
            },
            lualine_x = {
                'encoding',
                {
                    'fileformat', symbols = { unix = 'Unix', dos = 'Dos', mac = 'Mac' }
                },
                'filetype'},
                lualine_y = {
                    progress,"progress"
                },
            lualine_z = {
                {
                    "location", separator = { right = '▊▊' },jleft_padding = 0 }
                }
            },
        inactive_sections = {
            lualine_a = {
                "filename"
            },
            lualine_b = {},
            lualine_c = {
                "tabs"
            },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        }
    })
end

return M
