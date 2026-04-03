return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		defaults = {
			layout_strategy = "horizontal",
			layout_config = {
				preview_width = 0.55,
			},
			sorting_strategy = "ascending",
			prompt_prefix = "> ",
		},
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
	},
}
