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

          -- maps.n["<leader>:o"] = {
          --   "<Cmd>CodeCompanionChat<cr>",
          --   desc = "Olamma",
          -- }

          maps.n["<leader>:c"] = {
            "<cmd>CodeCompanion<cr>",
            desc = "Copilot",
          }

          maps.n["<leader>:a"] = {
            "<cmd>CCodeCompanionActions<cr>",
            desc = "Actions",
          }

          maps.n["<leader>:"] = {
            "<cmd>CodeCompanion<cr>",
            desc = "Prompt",
          }

          maps.n["<leader>:C"] = {
            "<cmd>CodeCompanionChat<cr>",
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
      local adapter = {
        adapter = "ollama",
        -- model = "yi-coder:1.5b",
        -- model = "yi-coder:9b",
        model = "deepseek-coder",
      }
      require("codecompanion").setup {
        strategies = {
          -- chat = adapter,
          chat = { adapter = "copilot" },
          inline = { adapter = "copilot" },
          agent = { adapter = "copilot" },
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
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "qwen",
              parameters = {
                sync = true,
              },
              schema = {
                model = {
                  default = "deepseek-coder",
                },
              },
            })
          end,

          -- ollama = {
          --   enabled = true,
          --   model = "deepseek-coder", -- The model you pulled with Ollama
          --   host = "http://localhost:11434", -- Default Ollama API endpoint
          --   context_window = 4096, -- Adjust based on your model's context window
          -- },
          -- ollama = function()
          --   return require("codecompanion.adapters").extend("ollama", {
          --     enabled = true,
          --     model = "deepseek-coder", -- The model you pulled with Ollama
          --     host = "http://localhost:11434", -- Default Ollama API endpoint
          --     context_window = 4096, -- Adjust based on your model's context window
          --   })
          -- end,

          -- ollama = function()
          --   return require("codecompanion.adapters").extend("openai_compatible", {
          --     -- env = {
          --     --   -- url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
          --     --   -- api_key = "OPENAI_API_KEY", -- optional: if your endpoint is authenticated
          --     --   chat_url = "/v1/chat/completions", -- optional: default value, override if different
          --     -- },
          --     schema = {
          --       model = {
          --         default = "deepseek-coder:1.3b",
          --       },
          --     },
          --   })
          -- end,

          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                --   -- url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
                api_key = os.getenv "GEMINI_API_KEY", -- optional: if your endpoint is authenticated
                --   chat_url = "/v1/chat/completions", -- optional: default value, override if different
              },
            })
          end,
        },
      }
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function() require("copilot").setup {} end,
  },
}
