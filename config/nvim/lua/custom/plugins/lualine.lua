-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

require("lualine").setup {
  options = {
    theme = "auto",
    icons_enabled = true,
    disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
    component_separators = " ",
    section_separators = { left = "|", right = "|" },
  },
    sections = {
        lualine_a = { { "mode", separator = { left = "[" }, right_padding = 3 } },
        lualine_b = {'filename', "branch", 'diagnostics', { "diff", colored = true } },
        lualine_c = {
            {'buffers',
            show_filename_only = true,   -- Shows shortened relative path when set to false.
            hide_filename_extension = false,   -- Hide filename extension when set to true.
            show_modified_status = true, -- Shows indicator when the buffer is modified.
            mode = 4,
            -- 0: Shows buffer name
            -- 1: Shows buffer index
            -- 2: Shows buffer name + buffer index
            -- 3: Shows buffer number
            -- 4: Shows buffer name + buffer number
            }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = { progress,"progress" },
        lualine_z = { { "location", separator = { right = "]" }, left_padding = 3 } },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {"tabs"},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}
