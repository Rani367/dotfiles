local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font({
	family = "FiraCode Nerd Font Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 27
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Fix terminal flashing on keypress
config.cursor_blink_rate = 0
config.force_reverse_video_cursor = true
config.visual_bell = {
	fade_in_duration_ms = 0,
	fade_out_duration_ms = 0,
}
config.audible_bell = "Disabled"

-- Background image with TokyoNight overlay
config.background = {
	{
		source = { File = wezterm.home_dir .. "/dotfiles/images/background.jpg" },
		hsb = { brightness = 0.2 },
		width = "Cover",
		height = "Cover",
	},
	{
		source = { Color = "#1a1b26" },
		opacity = 0.4,
		width = "100%",
		height = "100%",
	},
}

-- TokyoNight colors
config.colors = {
	foreground = "#c0caf5",
	background = "#1a1b26",
	cursor_bg = "#c0caf5",
	cursor_border = "#c0caf5",
	cursor_fg = "#1a1b26",
	selection_bg = "#283457",
	selection_fg = "#c0caf5",
	ansi = { "#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
	brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
}

local act = wezterm.action
config.keys = {
	{ key = "d", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "SUPER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
	{ key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },
}

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
