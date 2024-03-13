local wezterm = require('wezterm')
local colors = require('lua/theme/rose-pine-moon').colors()
local window_frame = require('lua/theme/rose-pine-moon').window_frame()
local gpus = wezterm.gui.enumerate_gpus()
local font = wezterm.font { family = 'MonoLisa Medium' }

local M = {
    -- environment variable
    set_environment_variables = {
        TERM = "xterm-256color",
        LC_ALL = "en_US.UTF-8",
    },
    -- fonts
    font = font,
    font_size = 16,
    freetype_load_target = "Normal",
    line_height = 1.2,
    -- window and tab
    window_frame = window_frame,
    window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW",
    window_padding = { left = 5, right = 5, top = 5, bottom = 5},
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    -- appearence
    colors = colors,
    window_background_opacity = 1,
    text_background_opacity = 1,
    default_cursor_style = 'BlinkingBar',
    cursor_thickness = 6.0,
    force_reverse_video_cursor = true,
    -- preformance
    webgpu_preferred_adapter = gpus[1],
    front_end = "WebGpu",
    webgpu_power_preference = "HighPerformance",
    max_fps = 200,
    animation_fps = 120,
    -- others
    tab_and_split_indices_are_zero_based = true,
    audible_bell="Disabled",
    send_composed_key_when_left_alt_is_pressed=true,
    enable_kitty_graphics = true,
}

return M
