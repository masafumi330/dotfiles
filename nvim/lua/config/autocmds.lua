-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- https://neovim.io/doc/user/api.html#nvim_create_autocmd()
-- nvim_create_autocmd({event}, {opts})
-- event list https://neovim.io/doc/user/autocmd.html#_5.-events

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("go_organize_imports"),
	pattern = "*.go",
	callback = function()
		-- vim.lsp.buf.code_action({
		-- 	apply = true,
		-- 	context = { only = { "source.organizeImports" }, diagnostics = {} },
		-- })
	end,
})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = augroup("organise_imports"),
--     pattern = { "*.ts", "*.tsx" },
--     callback = function()
--         vim.lsp.buf.code_action({
--             apply = true,
--             context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
--         })
--         -- vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" }, diagnostics = {} } })
--         vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports.ts" }, diagnostics = {} } })
--     end,
-- })
