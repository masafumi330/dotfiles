return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			-- typescript
			"vtsls",
			-- Go
			"delve",
			"gofumpt",
			"goimports",
			"golangci-lint",
			"gopls",
			-- SQL
			"sqlfmt",
			-- Perl
			"perlnavigator",
		},
	},
}
