-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- `nvim <dir>` で起動したとき、その dir に cd する
-- (cwd が起動元のままだと、ツリーを閉じて再度開いたときに起動元 cwd で開いてしまう)
local first_arg = vim.fn.argv(0)
if first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
  vim.cmd.cd(vim.fn.fnameescape(first_arg))
end
