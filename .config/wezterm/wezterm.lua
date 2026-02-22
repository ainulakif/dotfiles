-- ==========================================================================================
-- WEZTERM CONFIGURATION
-- ==========================================================================================
-- A well-organized, modular configuration for WezTerm
--
-- Structure:
--   wezterm.lua              - Main entry point (this file)
--   config/keys.lua          - All keybindings and key tables
--   config/events.lua        - Event handlers (startup, status bar)
--   config/experimental.lua.example  - Commented-out features for reference
--   utils/dev-layouts.lua    - Custom development layouts

-- Pull in the wezterm API
local wezterm = require('wezterm')

-- Plugins
local quick_domains = wezterm.plugin.require('https://github.com/DavidRR-F/quick_domains.wezterm')

-- This will hold the configuration
local config = wezterm.config_builder()

-- Multiplexer layer
local mux = wezterm.mux

-- ==========================================================================================
-- APPEARANCE
-- ==========================================================================================

-- Color scheme
config.color_scheme = 'Everforest Dark (Gogh)'

-- Font
config.font = wezterm.font('GeistMono Nerd Font', {
  weight = 'Regular'
})
config.line_height = 1.15
config.text_background_opacity = 1

-- Window
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.colors = {
  background = '#2a2f38',
  tab_bar = {
    background = '#2a2a38',
    active_tab = {
      bg_color = '#BCC3C3',
      fg_color = 'none',
    },
    inactive_tab = {
      bg_color = 'none',
      fg_color = '#BCC3C3',
      intensity = 'Half',
      strikethrough = true,
      italic = true
    },
    inactive_tab_edge = '#575757',
  }
}
config.foreground_text_hsb = {
  brightness = 0.95,
}
config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font({
    family = 'Noto Sans',
    weight = 'Regular',
  }),
  font_size = 9,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Panes
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.47,
}
config.pane_focus_follows_mouse = true

-- Cursor
config.default_cursor_style = 'BlinkingBar'
config.animation_fps = 1  -- Minimal animation for better performance
config.cursor_blink_ease_in = 'Constant'

-- ==========================================================================================
-- BASIC SETTINGS
-- ==========================================================================================

config.default_prog = {'zsh'}
config.use_dead_keys = false
config.scrollback_lines = 5000

-- Quick select patterns (files with common extensions + Redis keys)
config.quick_select_patterns = {
  -- Files with extensions
  [[\b[\w.-]+(?:\.sh|\.log|\.txt|\.php|\.py|\.json)\b]],

  -- Redis keys (must contain underscore, supports colons)
  [[\b[\w]+_[\w:]+\b]]
}

-- ==========================================================================================
-- PLUGINS CONFIGURATION
-- ==========================================================================================

-- Quick domains plugin for SSH domain management
quick_domains.apply_to_config(config, {
  keys = {
    hsplit = {
      key = "'",
      mods = 'LEADER',
      tbl = '',
    },
    vsplit = {
      key = '5',
      mods = 'LEADER',
      tbl = '',
    },
    attach = {
      mods = 'LEADER',
      key = 'd',
      tbl = '',
    },
  },
})

-- ==========================================================================================
-- LOAD MODULES
-- ==========================================================================================

-- Load keybindings
require('config.keys').apply_to_config(config)

-- Load event handlers
require('config.events').apply_to_config(config, mux)

-- Load development layouts
require('utils.dev-layouts').apply_to_config(wezterm)

-- ==========================================================================================
-- RETURN CONFIG
-- ==========================================================================================

return config
