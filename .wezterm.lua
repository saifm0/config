-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.front_end = "OpenGL"
config.max_fps = 240
config.default_cursor_style = "SteadyBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font_with_fallback({
	{ family = "0xProto Nerd Font Mono", weight = "Regular" }, -- main text
	{ family = "Symbols Nerd Font Mono" }, -- nerd-icons glyphs (required)
	{ family = "all-the-icons" },
	{ family = "Weather Icons" },
	{ family = "github-octicons" },
	{ family = "Material Icons" },
	{ family = "FontAwesome" },
	{ family = "file-icons" },
	{ family = "Noto Sans Symbols 2" },
	{ family = "Noto Color Emoji" },
	{ family = "Iosevka Nerd Font" }, -- CJK to avoid <U+####>
})
config.use_cap_height_to_scale_fallback_fonts = true
config.warn_about_missing_glyphs = true
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- optional (no ligs)
config.cell_width = 0.9
config.font_size = 14.0

-- We comment this out because we are defining the colors manually below.
-- config.color_scheme = "Gruvbox Dark"

-- CUSTOM GRUVBOX COLOR PALETTE
-- Based on the colors you provided from PowerShell.
config.colors = {
	-- The default background color
	background = "#282828",
	-- The default foreground color
	foreground = "#EBDBB2",

	-- Cursor colors
	cursor_bg = "#EBDBB2",
	cursor_fg = "#282828",
	cursor_border = "#EBDBB2",

	-- Selection colors. Using the theme's blue for a more integrated look.
	selection_bg = "#458588",
	selection_fg = "#282828",

	-- ANSI Colors (the 8 basic colors)
	ansi = {
		"#282828", -- black
		"#CC241D", -- red
		"#98971A", -- green
		"#D79921", -- yellow
		"#458588", -- blue
		"#B16286", -- purple
		"#689D6A", -- cyan
		"#EBDBB2", -- white
	},

	-- Bright ANSI Colors
	brights = {
		"#90796D", -- brightBlack
		"#FB4934", -- brightRed
		"#98971A", -- brightGreen
		"#FABD2F", -- brightYellow
		"#83A598", -- brightBlue
		"#D3869B", -- brightPurple
		"#8EC07C", -- brightCyan
		"#A89984", -- brightWhite
	},

	-- Themed tab bar
	tab_bar = {
		background = "#282828",
		active_tab = {
			bg_color = "#458588", -- Use blue for the active tab background
			fg_color = "#282828",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#282828",
			fg_color = "#A89984",
		},
		new_tab = {
			bg_color = "#282828",
			fg_color = "#A89984",
		},
	},
}

-- Set the background transparency.
config.window_background_opacity = 0.75
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Keymaps
config.keys = {
	{
		key = "v",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "h",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 20 },
		}),
	},
	{ key = "U", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "I", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "O", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "P", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "9", mods = "CTRL", action = act.PaneSelect },
	{ key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "q", mods = "ALT|CTRL", action = act.CloseCurrentPane({ confirm = true }) },
	{
		key = "O",
		mods = "CTRL|ALT",
		-- This keybind toggles opacity between fully opaque and our desired transparency
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.85
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
}

config.window_decorations = "NONE | RESIZE"
config.default_prog = { "pwsh.exe", "-NoLogo" }
config.initial_cols = 80

-- and finally, return the configuration to wezterm
return config
