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
  {
    "ton/vim-bufsurf",
    event = "VeryLazy",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<c-i>"] = { "<Plug>(buf-surf-forward)", desc = "Buffer surf forward" }
          maps.n["<c-o>"] = { "<Plug>(buf-surf-back)", desc = "Buffer surf backward" }
        end,
      },
    },
    config = function()
      local ok, cybu = pcall(require, "cybu")
      if not ok then return end
      cybu.setup()
      vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
      vim.keymap.set("n", "J", "<Plug>(CybuNext)")
      vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
      vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)")
    end,
  },
}
