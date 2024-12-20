return {
  {
    "github/copilot.vim",
    cmd = { "Copilot" },
    config = function()
      require("copilot").setup {
        panel = {
          auto_refresh = false,
          keymap = {
            accept = "<CR>",
            jump_prev = "<c-p>",
            jump_next = "<c-n>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
        suggestion = {
          enabled = true,
          -- auto_trigger = true,
          keymap = {
            accept = "<cr>",
            prev = "<c-p>",
            next = "<c-n>",
            dismiss = "<esc>",
          },
        },
      }
    end,
  },
  -- {
  --   "David-Kunz/gen.nvim",
  --   cmd = "Gen",
  --   lazy = true,
  --   dependencies = {
  --     {
  --       "AstroNvim/astrocore",
  --       opts = function(_, opts)
  --         local maps = opts.mappings
  --         maps.n["<Leader>og"] = { ":Gen<CR>", desc = "Ollama" }
  --         maps.n["<Leader>oG"] = { "<cmd>lua require('gen').select_model()<cr>", desc = "Change Ollama model" }
  --       end,
  --     },
  --   },
  --   opts = function(_, opts)
  --     opts.model = "mistral" -- The default model to use.
  --     opts.display_mode = "float" -- The display mode. Can be "float" or "split".
  --     opts.show_prompt = true -- Shows the Prompt submitted to Ollama.
  --     opts.show_model = true -- Displays which model you are using at the beginning of your chat session.
  --     opts.no_auto_close = false -- Never closes the window automatically.
  --
  --     opts.init = function(options) pcall(io.popen "ollama serve > /dev/null 2>&1 &") end
  --     -- Function to initialize Ollama
  --     opts.command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body"
  --     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  --     -- This can also be a lua function returning a command string, with options as the input parameter.
  --     -- The executed command must return a JSON object with { response, context }
  --     -- (context property is optional).
  --     -- list_models = "<omitted lua function>", -- Retrieves a list of model names
  --     opts.debug = false -- Prints errors and the command which is run.
  --   end,
  -- },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = true,
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --     provider = "openai",
  --
  --     -- add any opts here
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}
