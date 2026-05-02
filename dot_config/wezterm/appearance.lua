local wezterm = require("wezterm")
local module = {}

local BORDER_COLOR = "#7F77DD"
local ACTIVE_TAB_COLOR_BG = "#7F77DD"
local ACTIVE_TAB_COLOR_FG = "#FFFFFF"
local WORKSPACE_BAR_COLOR_BG = "#7F77DD"
local WORKSPACE_BAR_COLOR_FG = "#FFFFFF"

local appearance = {
	-- window title
	-- タイトルバーを非表示
	window_decorations = "RESIZE", -- NONE, TITLE, TITLE | RESIZE, RESIZE, INTEGRATED_BUTTONS
	window_close_confirmation = "NeverPrompt", -- AlwaysPrompt or NeverPrompt

	-- Pane
	-- 非アクティブPaneを暗くして視認性を向上
	-- アクティブPaneは青みがかった背景、非アクティブは暗くする
	inactive_pane_hsb = {
		hue = 0.9, -- 色相を少しシフト（青みを抑える）
		saturation = 0.9,
		brightness = 1.0,
	},

	-- 透過度：0.0（完全透過）〜 1.0（不透明）
	window_background_opacity = 0.7,
	macos_window_background_blur = 50,

	-- Tab
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	show_new_tab_button_in_tab_bar = false,
	tab_max_width = 30,
	use_fancy_tab_bar = true,
	-- use_fancy_tab_bar = trueの場合のタブバー透過設定
	window_frame = {
		font_size = 13.0, -- default 12.0,
		-- inactive_titlebar_bg = "none",
		-- active_titlebar_bg = "none",
		border_left_width = "0.5cell",
		border_right_width = "0.5cell",
		border_bottom_height = "0.25cell",
		border_top_height = "0.25cell",
		border_left_color = BORDER_COLOR,
		border_right_color = BORDER_COLOR,
		border_bottom_color = BORDER_COLOR,
		border_top_color = BORDER_COLOR,
	},
	-- Hide borders between tabs
	colors = {
		-- カーソルとコピーモード選択色（WezTermデフォルト）
		cursor_bg = "#80EBDF",
		cursor_fg = "#000000",
		cursor_border = "#80EBDF",
		selection_bg = "#ffdd00",
		selection_fg = "#000000",
		tab_bar = {
			inactive_tab_edge = "none",
		},
		split = "#ecfa52",
	},

	font = wezterm.font("HackGen Console NF"),
	font_size = 14,
	color_scheme = "Tokyo Night",

	default_cursor_style = "BlinkingBlock",
}

-- -- Show current workspace name on right-tab-bar
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Background = { Color = WORKSPACE_BAR_COLOR_BG } },
		{ Foreground = { Color = WORKSPACE_BAR_COLOR_FG } },
		{ Text = " " .. window:active_workspace() .. " " },
	}))
end)

-- Color Active tab
local SOLID_LEFT_CIRCLE = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT_CIRCLE = wezterm.nerdfonts.ple_right_half_circle_thick
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = ACTIVE_TAB_COLOR_BG
		foreground = ACTIVE_TAB_COLOR_FG
	end
	local edge_foreground = background

	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_CIRCLE },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_CIRCLE },
	}
end)

function module.apply_to_config(config)
	for k, v in pairs(appearance) do
		config[k] = v
	end
end

return module
