return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup()
  end,
  keys = {
    { "<leader>D", function() require("dbee").toggle() end, desc = "Toggle DBee" },
  },
}
