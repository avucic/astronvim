return {
  {
    "avucic/workspace.nvim",
    dir = "~/Work/Neovim/workspace.nvim",
    event = "VeryLazy",
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
      -- local workspaces = require("plugins.custom.workspaces").
      require("workspace").setup {
        workspaces = {
          { name = "NLP", path = "~/Documents/NLP" },
          { name = "CV", path = "~/Documents/CV/jsonresume/" },
          { name = "PRICING_WALL-RUBY", path = "~/Work/pricingwall.com/dev/pricing_wall-ruby" },
          { name = "PRICING_WALL", path = "~/Work/pricingwall.com/dev/pricing_wall" },
          { name = "PRICING_WALL-WEB", path = "~/Work/pricingwall.com/dev/pricing_wall/web" },
          { name = "DROPONGO", path = "~/Work/Dropongo/Development/dropongo" },
          { name = "DOTFILES", path = "~/dotfiles" },
          { name = "NVIM", path = "~/dotfiles/nvim/.config/nvim" },
          { name = "NVIM_OLD", path = "~/dotfiles/nvim/.config/nvim_old" },
          { name = "TODO_TXT", path = "~/Work/todo-txt/Rust/todo-txt" },
        },
      }
    end,
  },
}
