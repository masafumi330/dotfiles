local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

local leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

local keys = {
	-- Pane
	{ key = ";", mods = "CTRL", action = act.PaneSelect },
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
		action = act.CloseCurrentPane({ confirm = true }),
	},
	-- Cmd+Q: 誤操作防止のため無効化
	{
		key = "q",
		mods = "SUPER",
		action = act.DisableDefaultAssignment,
	},
	-- Vim風Pane移動
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	-- Ctrl+B, S: Show Workspace
	{
		mods = "CTRL",
		key = "w",
		action = wezterm.action_callback(function(win, pane)
			-- workspace のリストを作成（現在のworkspaceを先頭に）
			local current = wezterm.mux.get_active_workspace()
			local workspaces = {}
			for _, name in ipairs(wezterm.mux.get_workspace_names()) do
				if name == current then
					table.insert(workspaces, 1, { id = name, label = name })
				else
					table.insert(workspaces, { id = name, label = name })
				end
			end
			for i, ws in ipairs(workspaces) do
				ws.label = string.format("%d. %s", i, ws.label)
			end
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
	-- Create new workspace with name
	{
		mods = "LEADER",
		key = "n",
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

function module.apply_to_config(config)
	config.leader = leader
	config.keys = keys
end

return module
