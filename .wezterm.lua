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
config.colors = {
	foreground = "#cdd6f4",
	background = "#1e1e2e",
	cursor_bg = "#f5e0dc",
	cursor_border = "#f5e0dc",
	cursor_fg = "#1e1e2e",
	selection_bg = "#585b70",
	selection_fg = "#cdd6f4",
	ansi = { "#45475a", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#bac2de" },
	brights = { "#585b70", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#a6adc8" },
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

wezterm.on('gui-startup', function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
