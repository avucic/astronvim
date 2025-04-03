return {
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        backend = { "telescope" },
        telescope = {
          layout_config = {
            preview_cutoff = false,
            -- width = function(_, max_columns, _) return math.min(max_columns, 160) end,
            -- height = function(_, _, max_lines) return math.min(max_lines, 15) end,
          },
        },
      },
    },
  },
}
