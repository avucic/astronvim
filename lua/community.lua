-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.ruby" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.markdown" },

  -- TODO:
  -- 1.fix telescope-nvchad-theme
  -- 2. lazy load some plugins like dial, leap, harpoon

  -- { import = "astrocommunity.recipes.telescope-nvchad-theme" },
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
  { import = "astrocommunity.utility.nvim-toggler" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity/editing-support/true-zen-nvim" },
  { import = "astrocommunity/editing-support/text-case-nvim" },
  { import = "astrocommunity/editing-support/treesj" },
  { import = "astrocommunity/editing-support/dial-nvim" },
  { import = "astrocommunity/split-and-window/windows-nvim" },
  { import = "astrocommunity.debugging.nvim-bqf" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.indent.indent-blankline-nvim" },

  {
    "stevearc/overseer.nvim",
    init = function(_)
      require("astrocore").set_mappings {
        n = {
          ["<Leader>tT"] = { "<cmd>OverseerToggle<cr>", desc = "Toggle" },
          ["<Leader>tt"] = { "<cmd>OverseerRun<cr>", desc = "Run" },
          ["<Leader>tl"] = { "<cmd>OverseerRestartLast<cr>", desc = "last task" },
          ["<Leader>ta"] = { "<cmd>OverseerQuickAction<cr>", desc = "Task action" },
        },
      }
    end,
    opts = {
      strategy = "toggleterm",
    },
    config = function(_, opts)
      local overseer = require "overseer"
      overseer.setup(opts)

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local tasks = overseer.list_tasks { recent_first = true }
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end,
  },
  {
    "Pocco81/true-zen.nvim",
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<c-w>u"] = { desc = "True Zen" }
          maps.n["<c-w>ua"] = maps.n["<Leader>za"]
          maps.n["<c-w>uf"] = maps.n["<Leader>zf"]
          maps.n["<c-w>um"] = maps.n["<Leader>zm"]
          maps.n["<c-w>un"] = maps.n["<Leader>zn"]
          maps.n["<Leader>z"] = false
          maps.n["<Leader>za"] = false
          maps.n["<Leader>zf"] = false
          maps.n["<Leader>zm"] = false
          maps.n["<Leader>zn"] = false
        end,
      },
    },
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<c-w>="] = { "<cmd>WindowsEqualize<CR><cmd>WindowsDisableAutowidth<cr>", desc = "Equalize" }
          maps.n["<c-w>z"] = { "<cmd>WindowsMaximize<CR>", desc = "Maximize" }
        end,
      },
    },
  },
  {
    "nguyenvukhang/nvim-toggler",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>xt"] = maps.n["<Leader>i"]
          maps.n["<Leader>"] = nil
        end,
      },
    },

    opts = {
      inverses = {
        ["build"] = "create",
        ["after"] = "before",
        ["required"] = "optional",
        ["key"] = "value",
        ["if"] = "unless",
        ["yes"] = "no",
        ["on"] = "off",
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.v["<leader>xi"] = { "<cmd>TextCaseOpenTelescope<CR>", desc = "Open Smart Case Telescope" }
        end,
      },
    },
  },
  {
    "Wansmer/treesj",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["gJ"] = maps.n["<Leader>m"]
          maps.n["<Leader>m"] = nil
        end,
      },
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        signature = { enabled = false },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User AstroFile",
    opts = {
      scope = {
        enabled = true,
      },
    },
  },
}
