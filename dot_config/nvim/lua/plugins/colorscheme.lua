return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, _)
        hl.WinSeparator = { fg = "#5eacd3", bold = true }
      end,
    },
  },
}
