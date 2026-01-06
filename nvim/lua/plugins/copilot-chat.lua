return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			model = "gpt-4.1", -- AI model to use
			temperature = 0.1, -- Lower = focused, higher = creative
			headers = {
				user = "👤 ",
				assistant = "🤖 ",
				tool = "🔧 Tool",
			},
			auto_insert_mode = true, -- Enter insert mode when opening
			prompts = {
				Explain = {
					prompt = "/COPILOT_EXPLAIN 選択したコードの説明を段落をつけて書いてください。",
				},
				Fix = {
					prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。",
				},
				Optimize = {
					prompt = "/COPILOT_OPTIMIZE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
				},
				Docs = {
					prompt = "/COPILOT_DOCS 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）",
				},
				Tests = {
					prompt = "/COPILOT_TESTS 選択したコードの詳細な単体テスト関数を書いてください。",
				},
				FixDiagnostic = {
					prompt = "/COPILOT_FIXDIAGNOSTIC ファイル内の次のような診断上の問題を解決してください：",
				},
				Commit = {
					prompt = "/COPILOT_COMMIT この変更をコミットしてください。",
				},
				CommitStaged = {
					prompt = "/COPILOT_COMMITSTAGED ステージングされた変更をコミットしてください。",
				},
			},
			window = {
				layout = "vertical",
				width = 0.3,
			},
		},
		keys = {
			{
				"<leader>ct",
				"<cmd>CopilotChatToggle<cr>",
				desc = "CopilotChat - Toggle",
			},
		},
	},
}
