return {
  {
    "Vonr/align.nvim",
    event = { "User AstroFile" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          maps.v["<leader>xac"] = { "<cmd>lua require'align'.align_to_char({ length = 1 })<cr>", desc = "1 character" }
          maps.v["<leader>xas"] =
            { "<cmd>lua require'align'.align_to_char({ length = 2, preview = true })<cr>", desc = "2 characters" }
          maps.v["<leader>xaw"] =
            { "<cmd>lua require'align'.align_to_string({ preview = true, regex = false })<cr>", desc = "String" }
          maps.v["<leader>xar"] =
            { "<cmd>lua require'align'.align_to_char({ preview = true, regex = true })<cr>", desc = "Pattern" }
        end,
      },
    },
  },
  {

    "mfussenegger/nvim-treehopper",
    event = "VeryLazy",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["gV"] = { "<cmd>lua require('tsht').nodes()<cr>" }
          maps.v["gV"] = { "<cmd>lua require('tsht').nodes()<cr>" }
        end,
      },
    },
  },
}
