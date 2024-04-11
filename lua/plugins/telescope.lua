-- AstroCommunity: import any community modules here
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = require "plugins.configs.telescope",
  },
  {
    "princejoogie/dir-telescope.nvim",
    -- telescope.nvim is a required dependency
    requires = { "nvim-telescope/telescope.nvim" },
    opts = {
      hidden = false,
      respect_gitignore = true,
    },
  },
  {
    "axkirillov/easypick.nvim",
    config = function()
      local easypick = require "easypick"
      local base_branch = "master"
      easypick.setup {
        pickers = {
          -- diff current branch with base_branch and show files that changed with respective diffs in preview
          {
            name = "changed_files",
            command = "git diff --name-only $(git rev-parse --abbrev-ref HEAD)",
            previewer = easypick.previewers.branch_diff { base_branch = base_branch },
          },
        },
      }
    end,
    cmd = { "Easypick" },
  },
  {
    "nvim-telescope/telescope-project.nvim",
  },
  -- {
  --   "gbrlsnchs/telescope-lsp-handlers.nvim",
  -- },
  -- {
  --   "nvim-telescope/telescope-live-grep-args.nvim", -- live grap with args
  -- },
  -- -- {
  -- --   "avucic/telescope-vim-bookmarks.nvim",
  -- --   init = require("user.plugins.configs.vim_bookmarks").init,
  -- --   dependencies = { "MattesGroeger/vim-bookmarks" },
  -- --   cmd = {
  -- --     "BookmarkToggle",
  -- --     "BookmarkAnnotate",
  -- --     "BookmarkClear",
  -- --     "BookmarkClearAll",
  -- --   },
  -- -- },
  -- {
  --   "johmsalas/text-case.nvim",
  --   cmd = {
  --     "Subs",
  --     "TextCaseOpenTelescope",
  --     "TextCaseOpenTelescopeQuickChange",
  --     "TextCaseOpenTelescopeLSPChange",
  --   },
  --   config = function() require("textcase").setup() end,
  --   -- keys = {
  --   --   { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
  --   -- },
  -- },
  -- {
  --   "nvim-telescope/telescope-media-files.nvim",
  -- },
  -- {
  --   "nvim-telescope/telescope-project.nvim",
  -- },
  -- { "LukasPietzschmann/telescope-tabs" },
  -- {
  --   "danielfalk/smart-open.nvim",
  --   dependencies = {
  --     "kkharji/sqlite.lua",
  --     "nvim-telescope/telescope-fzy-native.nvim",
  --   },
  --   -- branch = "0.2.x",
  -- },
  -- {
  --   "gbprod/yanky.nvim",
  --   event = "User AstroFile",
  --   config = function() require("yanky").setup() end,
  -- },
}
