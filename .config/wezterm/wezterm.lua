-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- Plugins
-- local modalWezterm = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
local quick_domains = wezterm.plugin.require("https://github.com/DavidRR-F/quick_domains.wezterm")

-- This will hold the configuration
-- local config = wezterm.config_builder()
local config = {}

-- multiplexer layer
local mux = wezterm.mux

-- Color scheme
config.color_scheme = "Catppuccin Mocha (Gogh)"
-- config.enable_bracket_paste = false

-- config.background = {
--   {
--     source = { File = 'Pictures/gif/teto-tetoris.gif'},
--     vertical_align = 'Middle',
--     horizontal_align = 'Center',
--     height = "30%",
--     width = "20%",
--     repeat_x = "NoRepeat",
--     repeat_y = "NoRepeat",
--     opacity = 0.5,
--   },
--   -- Color = "black"
-- }

-- wezterm.mux.spawn_window {
--   position = {
--     x = 10,
--     y = 300,
--   },
-- }

-- local test = window:window_id()
-- wezterm.log_info(test)

-- local workspaces = wezterm.mux.get_workspace_names()
-- for i, name in ipairs(workspaces) do
--   wezterm.log_info("Workspace: " .. name)
-- end

-- wezterm.on("fetch_window_id", function(window)
--   local win_id = window:window_id()
--
-- end)

config.default_prog = {"zsh"}

-- auto maximize on startup
wezterm.on("gui-startup", function()
  local home = os.getenv("HOME")
	local tab, pane, window = mux.spawn_window({
    args = {"zsh", "-l", "-c", "sleep 0.5; fastfetch; " .. home .. "/Projects/scripts/bash-spinner/routine-check.sh; exec zsh"}
  })
	window:gui_window():maximize()

end)

-- config.default_prog = {"zsh", "-c", "echo 'Welcome ...'; sleep 1; fastfetch; /home/ainulakif/Projects/scripts/routine-check_test.sh; zsh"}

-- show font size (?)
-- wezterm.on('show-font-size', function(window, pane)
--   wezterm.log_error(window:effective_config().font_size)
-- end)

-- Font
config.font = wezterm.font("GeistMono Nerd Font")
config.font_size = 11
config.line_height = 1
config.text_background_opacity = 1

-- Window
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.colors = {
  tab_bar = {
    background = "none",

    active_tab ={
      bg_color = "#BCC3C3",
      fg_color = "none",
    },
    inactive_tab ={
      bg_color = "none",
      fg_color = "#BCC3C3",
      intensity = "Half",
      strikethrough = true,
      italic = true
    },
    inactive_tab_edge = '#575757',
  }
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.73
config.window_frame = {
  -- inactive_titlebar_bg = "none",
  -- active_titlebar_bg = "none",
	font = wezterm.font({
		family = "Noto Sans",
		weight = "Regular",
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
-- Activate pane by mouse pointer
config.pane_focus_follows_mouse = true

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"

-- status
wezterm.on("update-status", function(window, pane)
--   local overrides = window:get_config_overrides() or {}
--   local win_id = window:window_id()
--
--   wezterm.log_info("Window ID: " .. win_id)
--   if win_id == 0 then
--     wezterm.log_info('true')
--    overrides.enable_tab_bar = false
--   elseif win_id > 0 then
--     wezterm.log_info('true')
--    overrides.enable_tab_bar = true
--   else
--     wezterm.log_info('false')
--    overrides.enable_tab_bar = nil
--   end
--   -- window:set_config_override(overrides)
--   window:set_config_override({enable_tab_bar = true})
--
end)

wezterm.on("update-right-status", function(window, pane)

  -- set indicator when leader key is pressed
  local prefix = ""

  if window:leader_is_active() then
    prefix = "LEADER "
  end

  window:set_right_status(wezterm.format {
    { Text = prefix },
  })
-- 	local name = window:active_key_table()
-- 	local date = wezterm.strftime("%Y-%m-%d %H:%M:%S ")
--
-- 	if name then
-- 		name = name
-- 		window:set_right_status(name or "")
-- 	else
-- 		window:set_right_status(date)
-- 	end
--
-- 	local icon = ""
-- 	local val = ""
-- 	for _, b in ipairs(wezterm.battery_info()) do
-- 		val = b.state_of_charge * 100.7
--
-- 		if val <= 0 then
-- 			icon = "  "
-- 		elseif val <= 20 then
-- 			icon = "  "
-- 		elseif val <= 40 then
-- 			icon = "  "
-- 		elseif val <= 60 then
-- 			icon = "  "
-- 		elseif val <= 80 then
-- 			icon = "  "
-- 		elseif val > 80 then
-- 			icon = "  "
-- 		end
--
-- 		-- val = string.format("%.0f%%", val)
-- end
--
-- 	window:set_left_status(wezterm.format({
-- 		-- { Text = icon .. val },
-- 		{ Text = icon },
-- 	}))
end)

-- leader
config.leader = { key = "Space", mods = "SHIFT" }


-- Keys
config.keys = {

	-- This will create a new split and run your default program inside it
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- Open launcher args
	{
		key = "9",
		mods = "ALT",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|TABS|WORKSPACES" }),
	},

	-- Move focus to specific split pane with CTRL + 1, 2, 3, 4, 5
	{ key = "1", mods = "CTRL", action = wezterm.action.ActivatePaneByIndex(0) },
	{ key = "2", mods = "CTRL", action = wezterm.action.ActivatePaneByIndex(1) },
	{ key = "3", mods = "CTRL", action = wezterm.action.ActivatePaneByIndex(2) },
	{ key = "4", mods = "CTRL", action = wezterm.action.ActivatePaneByIndex(3) },
	{ key = "5", mods = "CTRL", action = wezterm.action.ActivatePaneByIndex(4) },

	-- show the pane selection mode, but have it swap the active and selected panes
	{
		key = "0",
		mods = "CTRL",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},

	-- Zoom state of the current pane
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- Returns a lua table representing the effective config for the Windows
	-- keys = {
	--   {
	--     key = 'E',
	--     mods = 'CTRL',
	--     action = wezterm.action.EmitEvent 'show-font-size',
	--   },
	-- },
	{
		key = "H",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "L",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},

	-- activate pane in direction
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},

	-- resize-pane mode until esc
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},

  -- rebind key
  {
    key = 'L',
    mods = 'LEADER',
    action = act.SendKey {
      key = 'RightArrow'
    },
  },
  {
    key = 'K',
    mods = 'LEADER',
    action = act.SendKey {
      key = 'UpArrow'
    },
  },
  {
    key = 'J',
    mods = 'LEADER',
    action = act.SendKey {
      key = 'DownArrow'
    },
  },
  {
    key = 'H',
    mods = 'LEADER',
    action = act.SendKey {
      key = 'LeftArrow'
    },
  },
  {
    key = 'End',
    mods = 'SHIFT',
    action = act.SendKey {
      key = 'Home'
    },
  },
}

-- define key tables
config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

config.use_dead_keys = false
config.scrollback_lines = 5000

-- Plugins config

-- modalWezterm.apply_to_config(config)
quick_domains.apply_to_config(config, {
	keys = {
		hsplit = {
			key = "'",
			mods = "LEADER",
			tbl = "",
		},
		vsplit = {
			key = "5",
			mods = "LEADER",
			tbl = "",
		},
		attach = {
			-- mod keys for fuzzy domain finder
			mods = "LEADER",
			-- base key for fuzzy domain finder
			key = "d",
			-- key table to insert key map to if any
			tbl = "",
		},
	},
})

-- Return the configuration to wezterm
return config
