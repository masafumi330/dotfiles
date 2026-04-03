-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- 透過度：0.0（完全透過）〜 1.0（不透明）
config.window_background_opacity = 0.95

-- configures the window size (window width & size) for newly created windows
config.initial_cols = 150
config.initial_rows = 32

config.font_size = 14
config.color_scheme = "Tokyo Night"

local act = wezterm.action

config.keys = {
	-- Cmd+D: 縦に分割（左右）
	{
		key = "d",
		mods = "SUPER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Cmd+Shift+D: 横に分割（上下）
	{
		key = "d",
		mods = "SUPER|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Cmd+W: 現在のPaneを閉じる（1つだけならタブを閉じる）
	{
		key = "w",
		mods = "SUPER",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	-- Vim風Pane移動
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
}

-- Finally, return the configuration to wezterm:
return config
