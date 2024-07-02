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
    "chrisgrieser/nvim-spider",
    event = { "User AstroFile" },
    -- opts = {
    --   skipInsignificantPunctuation = false,
    -- },
    keys = {
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },

      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },

      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
      -- ...
    },
  },
}
