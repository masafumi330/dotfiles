local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.use_ime = true

-- オーバーレイペインでコマンドを実行するヘルパー関数
local function spawn_overlay_pane(command)
	return wezterm.action_callback(function(window, pane)
		local act = wezterm.action
		local new_pane = pane:split({
			direction = "Bottom",
			size = 1.0,
			args = { os.getenv("SHELL"), "-lc", command },
		})
		window:perform_action(act.TogglePaneZoomState, new_pane)
	end)
end

-- augment-command-palette イベントでコマンドパレットにカスタムアクションを追加
wezterm.on("augment-command-palette", function(_, _)
	local commands = {
		{
			brief = "Launch: zsh",
			icon = "dev_terminal",
			action = spawn_overlay_pane("zsh"),
		},
		{
			brief = "Layout: vde-layout web-dev (new tab)",
			icon = "md_view_column",
			action = wezterm.action_callback(function(_, _)
				wezterm.background_child_process({
					os.getenv("SHELL") or "/bin/zsh",
					"-lic",
					"vde-layout web-dev",
				})
			end),
		},
		{
			brief = "Layout: vde-layout nippo (new tab)",
			icon = "md_note_edit",
			action = wezterm.action_callback(function(_, _)
				wezterm.background_child_process({
					os.getenv("SHELL") or "/bin/zsh",
					"-lic",
					"vde-layout nippo",
				})
			end),
		},
	}
	return commands
end)

require("appearance").apply_to_config(config)
require("keymaps").apply_to_config(config)

-- Finally, return the configuration to wezterm:
return config
