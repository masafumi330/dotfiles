return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	opts = {
		-- or "fzf-lua" or "snacks" or "default"
		picker = "snacks",
		-- bare Octo command opens picker of commands
		enable_builtin = true,
		mappings = {
			review_diff = {
				toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
			},
		},
	},
	keys = {
		{
			"<leader>op",
			"<CMD>Octo pr list<CR>",
			desc = "List GitHub PullRequests",
		},
		{
			"<leader>on",
			"<CMD>Octo notification list<CR>",
			desc = "List GitHub Notifications",
		},
		{
			"<leader>os",
			function()
				require("octo.utils").create_base_search_command({ include_current_repo = true })
			end,
			desc = "Search GitHub",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}
