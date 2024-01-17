local wezterm = require 'wezterm'
local mux = wezterm.mux
local colors = require('lua/theme/rose-pine-moon').colors()
local window_frame = require('lua/theme/rose-pine-moon').window_frame()
local config_font = {}

wezterm.on('gui-startup', function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

local font = wezterm.font { family = 'MonoLisa Medium' }

local font_rules = {
  {
    italic = true,
    intensity = 'Bold',
    font = wezterm.font {
      family = 'MonoLisa',
      weight = 'Bold',
      style = 'Italic',
    },
  },
{
    italic = false,
    intensity = 'Bold',
    font = wezterm.font {
      family = 'MonoLisa',
      weight = 'Bold',
    },
  },
  {
    italic = true,
    intensity = 'Half',
    font = wezterm.font {
      family = 'MonoLisa',
      weight = 'DemiBold',
      style = 'Italic',
    },
  },
  {
    italic = false,
    intensity = 'Half',
    font = wezterm.font {
      family = 'MonoLisa',
      weight = 'DemiBold',
    },
  },
  {
    italic = true,
    intensity = 'Normal',
    font = wezterm.font {
      family = 'MonoLisa',
      weight = 'Medium',
      style = 'Italic',
    },
  },
  {
    italic = false,
    intensity = 'Normal',
    font = wezterm.font {
      family = 'MonoLisa',
      weight = 'Medium',
    },
  },
}

return {
    font = font,
    font_rules = font_rules,
    font_size = 16,
    freetype_load_target = "Normal",
    line_height = 1.2,
    colors = colors,
    window_frame = window_frame, -- needed only if using fancy tab bar
    window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW",
    window_background_opacity = 0.8,
    window_padding = { left = 10, right = 10, top = 0, bottom = 0 },
    use_fancy_tab_bar = false,
    tab_and_split_indices_are_zero_based = true,
    audible_bell="Disabled",
    send_composed_key_when_left_alt_is_pressed=true,
    max_fps = 200,
    hide_tab_bar_if_only_one_tab = true,
    default_cursor_style = 'BlinkingBar',
    cursor_thickness = 6.0
}

