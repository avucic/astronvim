return {
  {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<c-w>m"] = { "<cmd>WinShift<cr>", desc = "Move window" }
        end,
      },
    },
  },
}
