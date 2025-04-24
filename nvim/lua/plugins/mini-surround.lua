return {
	"echasnovski/mini.surround",
	event = "VeryLazy", -- Neovim 完全起動後に発火する. 軌道高速化.
	version = false, -- 最新を常に使うように
	opts = {
		mappings = {
			add = "gsa", -- Add surrounding in Normal and Visual modes
			delete = "gsd", -- Delete surrounding
			find = "gsf", -- Find surrounding (to the right)
			find_left = "gsF", -- Find surrounding (to the left)
			highlight = "gsh", -- Highlight surrounding
			replace = "gsr", -- Replace surrounding
			update_n_lines = "gsn", -- Update `n_lines`
		},
	},
}
