return {
  -- nvim-lint : markdownlint-cli2 の設定ファイルを ~/.markdownlint.yaml に固定
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = {
          "--config",
          vim.fn.expand("~/.markdownlint.yaml"),
          "-", -- read from stdin (nvim-lint passes buffer content via stdin)
        },
      },
    },
  },
}
