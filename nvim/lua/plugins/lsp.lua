local gopls = require("plugins.lsp.gopls")
local perlnavigator = require("plugins.lsp.perlnavigator")

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		opts = {
			servers = vim.tbl_deep_extend("force", gopls, perlnavigator),
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			for server, config in pairs(opts.servers) do
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end
		end,
	},
}
