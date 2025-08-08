local gopls = require("plugins.lsp.gopls")
local perlnavigator = require("plugins.lsp.perlnavigator")

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = vim.tbl_deep_extend("force", gopls, perlnavigator),
		},
	},
}
