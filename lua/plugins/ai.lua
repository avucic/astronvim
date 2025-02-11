return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<leader>:"] = { desc = "AI" }
          maps.n["<leader>:l"] = {
            function() require("codecompanion").prompt "lsp" end,
            desc = "Explain the LSP diagnostics for the selected code",
          }

          maps.n["<leader>:o"] = {
            "<Cmd>CodeCompanionChat<cr>",
            desc = "Olamma",
          }

          maps.n["<leader>:c"] = {
            "<cmd>CodeCompanion<cr>",
            desc = "Copilot",
          }

          maps.n["<leader>::"] = {
            "<cmd>CodeCompanion chat<cr>",
            desc = "Chat",
          }

          maps.v["<leader>:"] = { "AI" }
          maps.v["<leader>:e"] = {
            function() require("codecompanion").prompt "explain" end,
            desc = "Code explanation",
          }
          maps.v["<leader>:b"] = {
            function() require("codecompanion").prompt "buffer" end,
            desc = "Send the current buffer to the LLM alongside a prompt",
          }
          maps.v["<leader>:c"] = {
            function() require("codecompanion").prompt "commit" end,
            desc = "Generate a commit message",
          }
          maps.v["<leader>:f"] = {
            function() require("codecompanion").prompt "fix" end,
            desc = "Fix the selected code",
          }
          maps.v["<leader>:t"] = {
            function() require("codecompanion").prompt "lsp" end,
            desc = "Generate unit tests for selected code",
          }
        end,
      },
    },
    cmd = { "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanion" },
    config = function()
      require("codecompanion").setup {
        strategies = {
          chat = {
            adapter = "ollama",
          },
          inline = {
            adapter = "copilot",
          },
        },
        --
        -- adapters = {
        --   deepseek = function()
        --     return require("codecompanion.adapters").extend("openai_compatible", {
        --       env = {
        --         url = "https://api.deepseek.com",
        --         api_key = vim.env.DEEPSEEK_API_KEY,
        --       },
        --     })
        --   end,
        -- },
        -- strategies = {
        --   chat = { adapter = "deepseek" },
        --   inline = { adapter = "deepseek" },
        --   agent = { adapter = "deepseek" },
        -- },
        --
        --
        --
        -- adapters = {
        --   -- ollama = function()
        --   --   return require("codecompanion.adapters").extend("openai_compatible", {
        --   --     env = {
        --   --       -- url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
        --   --       api_key = "OPENAI_API_KEY", -- optional: if your endpoint is authenticated
        --   --       chat_url = "/v1/chat/completions", -- optional: default value, override if different
        --   --     },
        --   --   })
        --   -- end,
        --
        --   copilot = function()
        --     return require("codecompanion.adapters").extend("copilot", {
        --       -- env = {
        --       --   -- url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
        --       --   api_key = "OPENAI_API_KEY", -- optional: if your endpoint is authenticated
        --       --   chat_url = "/v1/chat/completions", -- optional: default value, override if different
        --       -- },
        --     })
        --   end,
        -- },
      }
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function() require("copilot").setup {} end,
  },
  -- {
  --   "github/copilot.vim",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   opts = {
  --     panel = {
  --       enabled = true,
  --       auto_refresh = false,
  --       keymap = {
  --         jump_prev = "[[",
  --         jump_next = "]]",
  --         accept = "<CR>",
  --         refresh = "gr",
  --         open = "<M-CR>",
  --       },
  --       layout = {
  --         position = "bottom", -- | top | left | right | horizontal | vertical
  --         ratio = 0.4,
  --       },
  --     },
  --     suggestion = {
  --       enabled = true,
  --       auto_trigger = false,
  --       hide_during_completion = true,
  --       debounce = 75,
  --       keymap = {
  --         accept = "<M-l>",
  --         accept_word = false,
  --         accept_line = false,
  --         next = "<M-]>",
  --         prev = "<M-[>",
  --         dismiss = "<C-]>",
  --       },
  --     },
  --     filetypes = {
  --       yaml = false,
  --       markdown = true,
  --       help = false,
  --       gitcommit = false,
  --       gitrebase = false,
  --       hgcommit = false,
  --       svn = false,
  --       cvs = false,
  --       ["."] = false,
  --     },
  --     copilot_node_command = "node", -- Node.js version must be > 18.x
  --     server_opts_overrides = {},
  --   },
  --   -- config = function(_, opts)
  --   local cmp = require "cmp"
  --   local copilot = require "copilot"
  --   local luasnip = require "luasnip"
  --
  --   copilot.setup(opts)
  --
  --
  --   local function set_trigger(trigger)
  --     vim.b.copilot_suggestion_auto_trigger = trigger
  --     vim.b.copilot_suggestion_hidden = not trigger
  --   end
  --
  --   -- Hide suggestions when the completion menu is open.
  --   cmp.event:on("menu_opened", function()
  --     if copilot.is_visible() then copilot.dismiss() end
  --     set_trigger(false)
  --   end)
  --
  --   -- Disable suggestions when inside a snippet.
  --   cmp.event:on("menu_closed", function() set_trigger(not luasnip.expand_or_locally_jumpable()) end)
  --
  --   vim.api.nvim_create_autocmd("User", {
  --     pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
  --     callback = function() set_trigger(not luasnip.expand_or_locally_jumpable()) end,
  --   })
  -- end,
  -- },
}
