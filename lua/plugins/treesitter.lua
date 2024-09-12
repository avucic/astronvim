-- Customize Treesitter
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.cedar = {
  install_info = {
    url = "~/Work/Neovim/tree-sitter-cedar",
    files = { "src/parser.c" },
  },
  filetype = "cedar", -- if filetype does not agrees with parser name
}

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      require("ts_context_commentstring").setup {}
      -- add more things to the ensure_installed table protecting against community packs modifying it
      -- opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      opts.ensure_installed = {
        "ruby",
        "go",
        "html",
        "css",
        "scss",
        "bash",
        "cmake",
        "cedar",
        -- "dockerfile",
        "hcl",
        "regex",
        "javascript",
        "elixir",
        "json",
        "http",
        "ledger",
        "lua",
        "python",
        "yaml",
        "markdown",
        "markdown_inline",
        "embedded_template",
        "query",
        "rust",
        "vim",
        "toml",
        "sql",
        "svelte",
        "make",
        "zig",
        "kdl",
        -- add more arguments for adding more treesitter parsers
        -- })
      }

      opts.markid = { enable = true }

      opts.incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = "<CR>",
          scope_incremental = "<CR>",
          node_incremental = "<TAB>",
          node_decremental = "<S-TAB>",
        },
      }

      opts.textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            -- ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            ["iC"] = "@class.inner",
            ["aC"] = "@class.outer",
            ["ic"] = "@comment.inner",
            ["ac"] = "@comment.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
            ["ast"] = "@statement.outer",
            ["isc"] = "@scopename.inner",
            ["iB"] = "@block.inner",
            ["aB"] = "@block.outer",
            ["ia"] = "@parameter.inner",
            ["aa"] = "@parameter.outer",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          -- include_surrounding_whitespace = true,
        },
      }
    end,
  },
  {
    "David-Kunz/markid",
    event = "BufReadPost",
  },
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
      "TSCaptureUnderCursor",
    },
  },
}
