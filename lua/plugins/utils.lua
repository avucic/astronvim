return {

  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = {
      "DBUI",
      "DBUIToggle",
    },
    init = function()
      vim.g.db_ui_auto_execute_table_helpers = 1

      vim.cmd [[
    augroup _sql
      autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      autocmd FileType sql,mysql,plsql nnoremap <buffer> <C-q> :DBUIToggle<CR>
    augroup end
  ]]
    end,
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>od"] = { desc = "DB" }
          maps.n["<Leader>odt"] = { "<cmd>DBUIToggle<cr>", desc = "Toggle DB Connection" }
        end,
      },
    },
  },
  {
    "voldikss/vim-browser-search",
    cmd = "BrowserSearch",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>sw"] = { "<cmd>BrowserSearch<cr>", desc = "Find work on Web" }
          maps.v["<Leader>sw"] = { "<cmd>BrowserSearch<cr>", desc = "Find work on Web" }
        end,
      },
    },
  },
  {
    "kraftwerk28/gtranslate.nvim",
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.v["<leader>xg"] = { desc = "Translate" }
          maps.v["<leader>xge"] = { ":'<,'>Translate English<CR>", desc = "English" }
          maps.v["<leader>xgs"] = { ":'<,'>Translate Serbian<CR>", desc = "Serbian" }
        end,
      },
    },
    cmd = "Translate",
    opts = {
      default_to_language = "English",
    },
  },
}
