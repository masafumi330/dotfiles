-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- 透過度：0.0（完全透過）〜 1.0（不透明）
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20

-- configures the window size (window width & size) for newly created windows
config.initial_cols = 150
config.initial_rows = 32

config.font = wezterm.font("HackGen Console NF")
config.font_size = 14
config.color_scheme = "Tokyo Night"

local act = wezterm.action

config.inactive_pane_hsb = {
	saturation = 0.8,
}

config.default_cursor_style = "BlinkingBlock"

-- font size for tab bar
config.window_frame = {
	font_size = 13.0, -- default 12.0
}

config.use_ime = true

-- Show current workspace name on right-tab-bar
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Background = { Color = "#00ff88" } },
		{ Foreground = { Color = "#000000" } },
		{ Text = " " .. window:active_workspace() .. " " },
	}))
end)

config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

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
	-- Ctrl+B, S: Show Workspace
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action_callback(function(win, pane)
			-- workspace のリストを作成
			local workspaces = {}
			for i, name in ipairs(wezterm.mux.get_workspace_names()) do
				table.insert(workspaces, {
					id = name,
					label = string.format("%d. %s", i, name),
				})
			end
			local current = wezterm.mux.get_active_workspace()
			-- 選択メニューを起動
			win:perform_action(
				act.InputSelector({
					action = wezterm.action_callback(function(_, _, id, label)
						if not id and not label then
							wezterm.log_info("Workspace selection canceled") -- 入力が空ならキャンセル
						else
							win:perform_action(act.SwitchToWorkspace({ name = id }), pane) -- workspace を移動
						end
					end),
					title = "Select workspace",
					choices = workspaces,
					fuzzy = true,
					-- fuzzy_description = string.format("Select workspace: %s -> ", current), -- requires nightly build
				}),
				pane
			)
		end),
	},
	-- Ctrl+B, Shift+S: Create new workspace with name
	{
		mods = "LEADER|SHIFT",
		key = "s",
		action = act.PromptInputLine({
			description = "(wezterm) Create new workspace:",
			action = wezterm.action_callback(function(win, pane, name)
				if not name then
					wezterm.log_info("no name canceled")
				else
					win:perform_action(act.SwitchToWorkspace({ name = name }), pane)
				end
			end),
		}),
	},
}

-- Finally, return the configuration to wezterm:
return config
