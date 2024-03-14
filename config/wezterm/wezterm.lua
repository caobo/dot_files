local wezterm = require('wezterm')
local colors = require('lua/theme/rose-pine-moon').colors()
local window_frame = require('lua/theme/rose-pine-moon').window_frame()
local gpus = wezterm.gui.enumerate_gpus()
local font = wezterm.font_with_fallback {
    {
        family = "MonoLisa",
        weight = "Medium",
        assume_emoji_presentation = false,
        freetype_load_target = "HorizontalLcd",
        freetype_render_target = "HorizontalLcd"
    },
    {family = "LXGW WenKai Mono",
    weight = "Medium",
    scale = 1.2,
    freetype_load_target = "HorizontalLcd",
    freetype_render_target = "HorizontalLcd"
}
}
local foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.2,
    brightness = 1.2,
}

local M = {
    -- environment variable
    set_environment_variables = {
        TERM = "xterm-256color",
    },
    -- fonts
    font = font,
    font_size = 16,
    line_height = 1.2,
    foreground_text_hsb = foreground_text_hsb,
    -- window and tab
    window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW",
    window_padding = { left = 5, right = 5, top = 5, bottom = 5},
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    -- appearence
    colors = colors,
    window_frame = window_frame,
    window_background_opacity = 1,
    text_background_opacity = 1,
    default_cursor_style = 'BlinkingBar',
    cursor_thickness = 5.0,
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
