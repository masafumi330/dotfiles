return {
  {
    "kndndrj/nvim-dbee",
    lazy = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "MattiasMTS/cmp-dbee",
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
  },
  {
    "MattiasMTS/cmp-dbee",
    dependencies = { "kndndrj/nvim-dbee" },
    ft = "sql",
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "cmp-dbee" })
    end,
  },
}
