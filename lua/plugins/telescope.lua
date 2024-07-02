-- AstroCommunity: import any community modules here
--
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
}
