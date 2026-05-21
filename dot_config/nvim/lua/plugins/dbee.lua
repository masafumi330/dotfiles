return {
  "kndndrj/nvim-dbee",
  lazy = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  cmd = { "Dbee" },
  keys = {
    { "<leader>D", function() require("dbee").toggle() end, desc = "Toggle DBee" },
  },
  config = function()
    require("dbee").setup({
      sources = {
        require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
      },
    })
  end,
}
