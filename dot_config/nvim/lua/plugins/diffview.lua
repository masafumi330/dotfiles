return {
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
		-- keys = {
		--   { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
		--   { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
		--   { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview Branch History" },
		--   { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
		-- },
		opts = {},
	},
}
