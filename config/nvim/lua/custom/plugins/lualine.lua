local M = {'nvim-lualine/lualine.nvim'}

M.event = { 'BufReadPost', 'BufNewFile' }

function M.config()

    -- cool function for progress
    -- local progress = function()
    --     local current_line = vim.fn.line(".")
    --     local total_lines = vim.fn.line("$")
    --     local chars = {
    --     "╞▰═════════╡",
    --     "╞═▰════════╡",
    --     "╞══▰═══════╡",
    --     "╞═══▰══════╡",
    --     "╞════▰═════╡",
    --     "╞═════▰════╡",
    --     "╞══════▰═══╡",
    --     "╞═══════▰══╡",
    --     "╞════════▰═╡",
    --     "╞═════════▰╡",
    --     }
    --     local line_ratio = current_line / total_lines
    --     local index = math.ceil(line_ratio * #chars)
    --     return chars[index]
    -- end

    local search_result = function()
        if vim.v.hlsearch == 0 then
            return ''
        end
        local last_search = vim.fn.getreg('/')
        if not last_search or last_search == '' then
            return ''
        end
        local searchcount = vim.fn.searchcount { maxcount = 9999 }
        return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
    end

    -- show attached lsp server name
    local lsp_info = function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()
        -- if next(clients) == nil then
        --     return msg
        -- end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return string.format("LSP server: [%s]", client.name)
            end
        end
        return msg
    end

    local love = function ()
        return  "♥"
    end

    local flower = function ()
        return "󰧱"
    end

    local lualine = require("lualine")

    lualine.setup({
        options = {
            theme = "rose-pine",
            -- theme = "horizon",
            icons_enabled = true,
            disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
            component_separators = " ",
            section_separators = { left = ' ', right = ' ' },
        },
        sections = {
            lualine_a = {
                {
                    "mode", separator = { left = '󰧱 ' }, right_padding = 0
                },
            },
            lualine_b = {
                'filename',
                love,
                "filesize",
                "branch",
                'diagnostics',
                {
                    "diff", colored = true
                }
            },
            lualine_c = {
                '%=',
                lsp_info,
                '%=',
            },
            lualine_x = {
                {
                    "selectioncount", draw_empty = false
                },
                search_result,
                'encoding',
                {
                    'fileformat', symbols = { unix = 'Unix', dos = 'Dos', mac = 'Mac' }
                },
                'filetype'},
                lualine_y = {
                   love
                },
            lualine_z = {
                "progress",
                {
                    "location",
                    separator = { right = ' 󰧱 ' },jleft_padding = 0 }
                }
            },
        inactive_sections = {
            lualine_a = {
                "filename"
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        }
    })

end

return M
