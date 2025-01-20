local M = {'nvim-lualine/lualine.nvim'}

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
        a = {bg = colors.green, fg = colors.black, gui = 'bold'},
        b = {bg = "none", fg = colors.white},
        c = {bg = "none", fg = colors.white}
    },
    insert = {
        a = {bg = colors.red, fg = colors.black, gui = 'bold'},
        b = {bg = "none", fg = colors.white},
        c = {bg = "none", fg = colors.white}
    },
    visual = {
        a = {bg = colors.violet, fg = colors.black, gui = 'bold'},
        b = {bg = "none", fg = colors.white},
        c = {bg = "none", fg = colors.black}
    },
    replace = {
        a = {bg = colors.black, fg = colors.white, gui = 'bold'},
        b = {bg = "none", fg = colors.white},
        c = {bg = "none", fg = colors.white}
    },
    command = {
        a = {bg = colors.green, fg = colors.black, gui = 'bold'},
        b = {bg = "none", fg = colors.white},
        c = {bg = "none", fg = colors.black}
    },
    inactive = {
        a = {bg = "none", fg = colors.red, gui = 'bold'},
        b = {bg = "none", fg = colors.red},
        c = {bg = "none", fg = colors.red}
    }
}

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

    local love = function ()
        return  [[♥]]
    end

    local everything_good = function ()
        local bufnr = vim.api.nvim_get_current_buf()
        if #(vim.diagnostic.get(bufnr)) == 0 then
            local msg = love()
            return msg
        else
            return  [[]]
        end
    end

    local flower = function ()
        return [[󰧱]]
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
                { everything_good, color={ fg=colors.red } },
                'filename',
                -- "filesize",
                {"branch", draw_empty=true},
                {'diagnostics', draw_empty=true},
                {
                    "diff", colored = true, draw_empty=true
                }
            },
            lualine_c = {
                -- '%=',
                lsp_info,
                -- '%=',
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
                { love, color={ fg=colors.red } },
                },
            lualine_z = {
                "progress",
                {
                    "location",
                    -- separator = { right = ' 󰧱 ' },
                    jleft_padding = 0 }
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
