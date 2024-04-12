require "plugins.configs.toggleterm.lazygit"
require "plugins.configs.toggleterm.lazydocker"
require "plugins.configs.toggleterm.tasks"
require "plugins.configs.toggleterm.scratchpad"
require "plugins.configs.toggleterm.vifm"

local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- Customize Toggleterm

---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings

          maps.n["<Leader>ot"] = { desc = "Terminal" }
          maps.n["<Leader>e"] = { "<cmd>lua _LAZYDOCKER_TOGGLE()<CR>", desc = "LazyDocker" }
          maps.n["<Leader>ot"] = { desc = "Terminal" }
          maps.n["<Leader>otf"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
          maps.n["<Leader>oth"] =
            { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" }
          maps.n["<Leader>otv"] =
            { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }

          maps.n["\\"] = "<Nop>"
          maps.n["\\\\"] = { "<cmd>ToggleTermToggleAll<cr>" }
        end,
      },
    },
    opts = function(_, opts)
      opts.size = function(term)
        local max_vertical = 80
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          local dynamic_size = vim.o.columns * 0.4
          if dynamic_size > max_vertical then
            return max_vertical
          else
            return dynamic_size
          end
        end
      end

      opts.on_create = function(term)
        if term.direction ~= "float" then set_terminal_keymaps() end
      end

      opts.on_open = function(term)
        -- vim.cmd("startinsert!")
      end
      -- open_mapping = [[\\]],
      opts.open_mapping = [[<c-\>]]
      opts.persist_size = true
      opts.shade_terminals = false
      opts.shading_factor = -8
      opts.insert_mappings = false
      opts.terminal_mappings = false
      opts.start_in_insert = true
      opts.direction = default_direction
      opts.highlights = {
        -- border = "Normal",
        -- background = "Normal",
        -- highlights which map to a highlight group name and a table of it's values
        -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        -- Normal = {
        --   guibg = "#ff6600",
        -- },
        -- NormalFloat = {
        --   guifg = "#ff6600",
        -- },
        -- FloatBorder = {
        --   guifg = "#1a1d24",
        --   -- guibg = "<VALUE-HERE>",
        -- },
      }
      opts.winbar = {
        enabled = false,
      }
    end,
  },
}
