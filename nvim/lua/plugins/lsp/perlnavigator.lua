return {
	perlnavigator = {
		cmd = { "/Users/m.masafumi/.n/bin/perlnavigator" },
		filetypes = { "perl" },
		root_dir = require("lspconfig.util").root_pattern(".git", "Makefile", "cpanfile"),
		settings = {
			perlnavigator = {
				perlPath = "/opt/homebrew/bin/perl",
				enableWarnings = true,
			},
		},
	},
}
