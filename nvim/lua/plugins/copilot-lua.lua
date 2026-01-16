return {
	"zbirenbaum/copilot.lua",
	enabled = false,
	dependencies = { "copilotlsp-nvim/copilot-lsp" },
	event = "VeryLazy",
	opts = {
		suggestion = {
			auto_trigger = true,
		},
		nes = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept_and_goto = "<leader>p",
				accept = false,
				dismiss = "<Esc>",
			},
		},
	},
}
