local M = { 'nvim-lualine/lualine.nvim' }

M.event = { 'BufReadPost', 'BufNewFile' }

local colors = {
    black        = '#232136',
    violet       = '#c4a7e7',
    white        = '#e0def4',
    red          = '#eb6f92',
    green        = '#9ccfd8',
    blue         = '#3e8fb0',
    yellow       = '#f6c177',
    gray         = '#6e6a86',
    darkgray     = '#2a283e',
    lightgray    = '#56526e',
    inactivegray = '#908caa',
}

local rose_theme = {
    normal = {
        a = { bg = "none", fg = colors.green, gui = 'bold' },
        b = { bg = "none", fg = colors.white },
        c = { bg = "none", fg = colors.white }
    },
    insert = {
        a = { bg = "none", fg = colors.red, gui = 'bold' },
        b = { bg = "none", fg = colors.white },
        c = { bg = "none", fg = colors.white }
    },
    visual = {
        a = { bg = "none", fg = colors.violet, gui = 'bold' },
        b = { bg = "none", fg = colors.white },
        c = { bg = "none", fg = colors.black }
    },
    replace = {
        a = { bg = colors.black, fg = colors.white, gui = 'bold' },
        b = { bg = "none", fg = colors.white },
        c = { bg = "none", fg = colors.white }
    },
    command = {
        a = { bg = colors.green, fg = colors.black, gui = 'bold' },
        b = { bg = "none", fg = colors.white },
        c = { bg = "none", fg = colors.black }
    },
    inactive = {
        a = { bg = "none", fg = colors.red, gui = 'bold' },
        b = { bg = "none", fg = colors.red },
        c = { bg = "none", fg = colors.red }
    }
}

function M.config()

    -- print current cursor position number/total line number : column number
    local cursor_position = function ()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local current_colunm = vim.fn.col(".")
        return string.format("(%s/%s):%s", current_line, total_lines, current_colunm)
    end

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
        local buf_filetype = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            ---@diagnostic disable-next-line: undefined-field
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_filetype) ~= -1 then
                return string.format("LSP: [%s]", client.name)
            end
        end
        return msg
    end

    local love = function()
        return [[♥]]
    end

    local everythis_is_good = function()
        if #(vim.diagnostic.get(0)) == 0 then
            local msg = love()
            return msg
        else
            return [[]]
        end
    end

    local flower = function()
        return [[󰧱]]
    end

    local micro_record = function()
        local reg = vim.fn.reg_recording()
        if reg == '' then return '' end -- not recording
        return "recording to " .. reg
    end

    local lualine = require("lualine")

    lualine.setup({
        options = {
            theme = rose_theme,
            icons_enabled = true,
            disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
            component_separators = " ",
            section_separators = { left = ' ', right = ' ' },
            always_divide_middle = true
        },
        sections = {
            lualine_a = {
                flower,
                {
                    "mode",
                    -- separator = { left = '󰧱 ' },
                    right_padding = 0,
                },
            },
            lualine_b = {
                { everythis_is_good, color = { fg = colors.red } },
                'filename',
                -- "filesize",
                { "branch",          draw_empty = true },
                { 'diagnostics',     draw_empty = true },
                {
                    "diff", colored = true, draw_empty = true
                }
            },
            lualine_c = {
                -- '%=',
                lsp_info,
                -- '%=',
            },
            lualine_x = {
                { micro_record, color = { fg = colors.yellow } },
                {
                    "selectioncount", draw_empty = false
                },
                search_result,
                'encoding',
                {
                    'fileformat', symbols = { unix = 'Unix', dos = 'Dos', mac = 'Mac' }
                },
                'filetype' },
            lualine_y = {
                { everythis_is_good, color = { fg = colors.red } },
            },
            lualine_z = {
                cursor_position,
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
