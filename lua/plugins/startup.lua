return {
  {
    "avucic/workspace.nvim",
    dir = "~/Work/Neovim/workspace.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>fp"] = { require("workspace").tmux_sessions, desc = "List workspaces" }
          maps.n["<Leader>fP"] = { require("workspace").workspaces, desc = "List workspaces" }
        end,
      },
    },
    config = function()
      require("workspace").setup {
        workspaces = {
          { name = "PRICING_WALL", path = "~/Work/pricingwall.com/dev/pricing_wall" },
          { name = "DOTFILES", path = "~/dotfiles" },
          { name = "NVIM", path = "~/dotfiles/nvim/.config/nvim" },
          { name = "NVIM_OLD", path = "~/dotfiles/nvim/.config/nvim_old" },
        },
      }
    end,
  },
}
