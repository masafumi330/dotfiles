return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 300,
    },
  },
  keys = {
    {
      "<leader>ub",
      function() require("gitsigns").toggle_current_line_blame() end,
      desc = "Toggle Git Blame (inline)",
    },
  },
}
