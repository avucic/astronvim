return {
  {
    "Vonr/align.nvim",
    event = { "User AstroFile" },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          maps.v["<leader>xac"] = { "<cmd>lua require'align'.align_to_char({ length = 1 })<cr>", desc = "1 character" }
          maps.v["<leader>xas"] =
            { "<cmd>lua require'align'.align_to_char({ length = 2, preview = true })<cr>", desc = "2 characters" }
          maps.v["<leader>xaw"] =
            { "<cmd>lua require'align'.align_to_string({ preview = true, regex = false })<cr>", desc = "String" }
          maps.v["<leader>xar"] =
            { "<cmd>lua require'align'.align_to_char({ preview = true, regex = true })<cr>", desc = "Pattern" }
        end,
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.cmd [[
        let g:VM_mouse_mappings = 1
        let g:VM_leader = ','
        " let g:VM_maps = {}
        " let g:VM_maps["Add Cursor At Pos"]            = '<c-c>'
        " let g:VM_maps['Visual Add']                   = '<c-c>'
        " let g:VM_maps["Select All"]                   = '<c-a>'
        " let g:VM_maps['Visual All']                   = '<c-a>'
      ]]
    end,
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
  },
}
