return {
	gopls = {
		settings = {
			-- Gopls: setting
			-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			gopls = {
				gofumpt = true,
				codelenses = {
					test = true, -- 関数やパッケージのテストを簡単に実行できるようにする
					tidy = true, -- go.modの整理を行う
				},
				hints = {
					assignVariableTypes = true, -- 変数の型が見えるようになる!!
					compositeLiteralTypes = true, -- 構造体の型が見えるようになる!!
					compositeLiteralFields = true, -- 構造体のフィールドの型が見えるようになる!!
					constantValues = true, -- 定数が何の値なのかが見える
					-- parameterNames = true,
				},
				analyses = {
					nilness = true, -- nilの可能性がある値にアクセスしようとしている場合に警告を出す
				},
				staticcheck = true,
			},
		},
	},
}
