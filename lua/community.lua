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
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript-all-in-one" },

  -- TODO:
  -- 1.fix telescope-nvchad-theme
  -- 2. lazy load some plugins like dial, leap, harpoon

  -- { import = "astrocommunity.recipes.telescope-nvchad-theme" },
  { import = "astrocommunity.code-runner.overseer-nvim" },
  { import = "astrocommunity.code-runner.sniprun" },
  { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
  { import = "astrocommunity.utility.nvim-toggler" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.before-nvim" },
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.editing-support.true-zen-nvim" },
  { import = "astrocommunity.editing-support.text-case-nvim" },
  { import = "astrocommunity.editing-support.treesj" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.split-and-window/windows-nvim" },
  { import = "astrocommunity.quickfix.nvim-bqf" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.indent.indent-blankline-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },
  { import = "astrocommunity.editing-support.yanky-nvim" },
  { import = "astrocommunity.note-taking.zk-nvim" },

  {
    "zk-org/zk-nvim",
    config = require("plugins.custom.zk").config,
    cmd = {
      "ZkOrphahs",
      "ZkLink",
      "ZkGrep",
      "ZkIndex",
      "ZkNew",
      "ZkNewFromTitleSelection",
      "ZkNewFromContentSelection",
      "ZkCd",
      "ZkNotes",
      "ZkBacklinks",
      "ZkLinks",
      "ZkInsertLinkAtSelection",
      "ZkInsertLink",
      "ZkMatch",
      "ZkTags",
      "ZkFindOrCreate",
      "ZkFindOrCreateJournalDailyNote",
      "ZkOpenNotes",
      "ZkFindOrCreateNote",
      "ZkFindOrCreateProjectNote",
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      go = "go",
      -- disable_defaults = true,
      -- diagnostic = false,
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    -- Prevents Neovim from freezing on plugin installation/update.
    -- See: <https://github.com/ray-x/go.nvim/issues/433>
    build = function() require("go.install").update_all() end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          maps.x["gV"] = maps.x["S"]
          maps.o["gV"] = maps.o["S"]
          maps.n["gV"] = maps.n["S"]

          maps.x["S"] = nil
          maps.o["S"] = nil
          maps.n["S"] = nil
        end,
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>y"] = { desc = "Yank" }
          maps.n["<Leader>yy"] = { "<Cmd>Telescope yank_history<CR>", desc = "Find yanks" }
        end,
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    init = function(_)
      require("astrocore").set_mappings {
        n = {
          ["<Leader>t<cr>"] = { "<cmd>OverseerToggle<cr>", desc = "Toggle" },
          ["<Leader>tt"] = { "<cmd>OverseerRun<cr>", desc = "Run" },
          ["<Leader>tl"] = { "<cmd>OverseerRestartLast<cr>", desc = "last task" },
          ["<Leader>ta"] = { "<cmd>OverseerQuickAction<cr>", desc = "Task action" },
        },
      }
    end,
    cmd = { "OverseerRestartLast" },
    opts = {
      strategy = {
        "toggleterm",
        -- load your default shell before starting the task
        use_shell = false,
        -- overwrite the default toggleterm "direction" parameter
        direction = "horizontal",
        -- overwrite the default toggleterm "highlights" parameter
        highlights = nil,
        -- overwrite the default toggleterm "auto_scroll" parameter
        auto_scroll = nil,
        -- have the toggleterm window close and delete the terminal buffer
        -- automatically after the task exits
        close_on_exit = false,
        -- have the toggleterm window close without deleting the terminal buffer
        -- automatically after the task exits
        -- can be "never, "success", or "always". "success" will close the window
        -- only if the exit code is 0.
        quit_on_exit = "never",
        -- open the toggleterm window when a task starts
        open_on_start = true,
        -- mirrors the toggleterm "hidden" parameter, and keeps the task from
        -- being rendered in the toggleable window
        hidden = true,
        -- command to run when the terminal is created. Combine with `use_shell`
        -- to run a terminal command before starting the task
        on_create = nil,
      },
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
          -- maps.n["<Leader>z"] = false
          -- maps.n["<Leader>za"] = false
          -- maps.n["<Leader>zf"] = false
          -- maps.n["<Leader>zm"] = false
          -- maps.n["<Leader>zn"] = false
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

  {
    "michaelb/sniprun",
    init = function(_)
      require("astrocore").set_mappings {
        n = { ["<Leader>rr"] = { "<cmd>SnipRun<cr>", desc = "Execute" } },
        v = { ["<Leader>rr"] = { "<cmd>SnipRun<cr>", desc = "Execute" } },
      }
    end,
  },
}
