return {
  {
    "natecraddock/workspaces.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("workspaces").setup {
        hooks = {
          open = { "Telescope find_files" },
        },
      }
    end,
    cmd = {
      "WorkspacesAdd",
      "WorkspacesAddDir",
      "WorkspacesRemove",
      "WorkspacesRemoveDir",
      "WorkspacesRename",
      "WorkspacesListDirs",
      "WorkspacesList",
      "WorkspacesOpen",
      "WorkspacesSyncDirs",
    },
  },
}
