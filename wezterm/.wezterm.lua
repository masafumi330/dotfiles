-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- 透過度：0.0（完全透過）〜 1.0（不透明）
config.window_background_opacity = 0.85

-- configures the window size (window width & size) for newly created windows
config.initial_cols = 150
config.initial_rows = 32

config.font_size = 14
config.color_scheme = "Tokyo Night"

config.window_decorations = "RESIZE"

-- Finally, return the configuration to wezterm:
return config
