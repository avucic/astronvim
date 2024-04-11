return {
  {
    "mg979/vim-visual-multi",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          maps.n["<C-n>"] = "<Nop>"
          maps.n["<C-p>"] = "<Nop>"
          maps.n["<M-n>"] = { "<Plug>(VM-Add-Cursor-Down)" }
          maps.n["<M-p>"] = { "<Plug>(VM-Add-Cursor-up)" }
        end,
      },
    },
    branch = "master",
    event = { "User AstroFile", "InsertEnter" },
    init = function()
      vim.g["VM_leader"] = "<m-\\>"
      vim.g["VM_default_mappings"] = 1
    end,
  },
}
