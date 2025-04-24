return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	version = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		files = {
			fd_opts = [[--type f --hidden --exclude .git --exclude node_modules --exclude '*.bundle.js' --exclude '*.lock']],
		},
		grep = {
			rg_opts = [[--hidden --column --line-number --no-heading --color=always --smart-case --glob '!node_modules/**' --glob '!*.bundle.js' --glob '!*.lock']],
		},
	},
	config = function(_, opts)
		-- デフォルト設定を読み込んだあとに fzf-lua セットアップ
		require("fzf-lua").setup(opts)

		-- ワークスペースごとの設定があれば読み込む（上書き可能）
		local local_config = vim.fn.getcwd() .. "/.fzf-lua-config.lua"
		if vim.fn.filereadable(local_config) == 1 then
			dofile(local_config)
		end
	end,
}
