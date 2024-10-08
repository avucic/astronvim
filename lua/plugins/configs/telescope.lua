return function(_, _)
  local actions = require "telescope.actions"
  -- local fb_actions = telescope.extensions.file_browser.actions
  local lga_actions = require "telescope-live-grep-args.actions"
  local state = require "telescope.actions.state"

  local yank_select_buf_clip = function()
    local buf_select = state.get_selected_entry()
    -- vim.cmd.redir('@+ | echo "' .. buf_select[1] .. '" | redir END')
    vim.fn.setreg("+", buf_select[1])
  end

  return {
    defaults = {
      preview = {
        mime_hook = function(filepath, bufnr, opts)
          local is_image = function(filepath)
            local image_extensions = { "png", "jpg", "jpeg", "gif" } -- Supported image formats
            local split_path = vim.split(filepath:lower(), ".", { plain = true })
            local extension = split_path[#split_path]
            return vim.tbl_contains(image_extensions, extension)
          end
          if is_image(filepath) then
            local term = vim.api.nvim_open_term(bufnr, {})
            local function send_output(_, data, _)
              for _, d in ipairs(data) do
                vim.api.nvim_chan_send(term, d .. "\r\n")
              end
            end

            vim.fn.jobstart(
              --
              { "viu", filepath },
              {
                on_stdout = send_output,
                stdout_buffered = true,
              }
            )
          else
            require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
          end
        end,
      },
      file_ignore_patterns = { "node_modules", "%.jpg", "%.png", "vendor", "tmp" },
      -- prompt_prefix = "❯ ",
      prompt_prefix = "   ",
      selection_caret = "❯ ",
      path_display = { "truncate" },
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          -- ["<C-j>"] = actions.cycle_history_next,
          -- ["<C-k>"] = actions.cycle_history_prev,
          ["<c-c>"] = actions.close,
          -- ["<C-e>"] = fb_actions.goto_home_dir,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          -- ["<m-d>"] = require("telescope.actions").delete_buffer,

          -- ["<C-c>"] = actions.close,
          --
          -- ["<Down>"] = actions.move_selection_next,
          -- ["<Up>"] = actions.move_selection_previous,
          --
          -- ["<CR>"] = actions.select_default,
          ["<C-s>"] = actions.select_horizontal,
          -- ["<C-v>"] = actions.select_vertical,
          -- ["<C-t>"] = actions.select_tab,
          --
          -- ["<C-u>"] = actions.preview_scrolling_up,
          -- ["<C-d>"] = actions.preview_scrolling_down,
          --
          -- ["<PageUp>"] = actions.results_scrolling_up,
          -- ["<PageDown>"] = actions.results_scrolling_down,
          --
          -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          -- ["<C-l>"] = actions.complete_tag,
          -- ["<C-a>"] = lga_actions.quote_prompt(),
          -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          --
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
          -- freeze the current list and start a fuzzy search in the frozen list
          ["<C-space>"] = actions.to_fuzzy_refine,
        },
        n = {
          ["q"] = actions.close,
          ["<c-c>"] = actions.close,
          ["<esc>"] = false,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          --   ["<CR>"] = actions.select_default,
          ["<C-s>"] = actions.select_horizontal,
          --   ["<C-v>"] = actions.select_vertical,
          --   ["<C-t>"] = actions.select_tab,
          --
          --   ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          --   ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          --   ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          --   ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          --
          -- ["<C-c>"] = require("telescope.actions").create_note,
          ["n"] = actions.move_selection_next,
          ["p"] = actions.move_selection_previous,
          ["d"] = actions.delete_buffer,
          ["<c-y>"] = yank_select_buf_clip,
          --   ["H"] = actions.move_to_top,
          --   ["M"] = actions.move_to_middle,
          --   ["L"] = actions.move_to_bottom,
          --
          --   ["<Down>"] = actions.move_selection_next,
          --   ["<Up>"] = actions.move_selection_previous,
          --   ["gg"] = actions.move_to_top,
          --   ["G"] = actions.move_to_bottom,
          --
          --   ["<C-u>"] = actions.preview_scrolling_up,
          --   ["<C-d>"] = actions.preview_scrolling_down,
          --
          --   ["<PageUp>"] = actions.results_scrolling_up,
          --   ["<PageDown>"] = actions.results_scrolling_down,
          --
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
        },
      },
    },
    -- pickers = {
    --   harpoon = {
    --     mappings = {
    --       i = {
    --         ["<C-n>"] = require("harpoon.ui").nav_next,
    --         ["<C-p>"] = require("harpoon.ui").nav_prev,
    --       },
    --       n = {
    --         ["<C-n>"] = require("harpoon.ui").nav_next,
    --         ["<C-p>"] = require("harpoon.ui").nav_prev,
    --       },
    --     },
    --   },
    -- },
    extensions = {
      -- workspaces = {
      --   -- keep insert mode after selection in the picker, default is false
      --   keep_insert = true,
      -- },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      lsp_handlers = {
        code_action = {
          telescope = require("telescope.themes").get_dropdown {},
        },
      },
      media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = { "png", "webp", "jpg", "jpeg", "gif" },
        find_cmd = "rg", -- find command (defaults to `fd`)
      },
      -- tailiscope = {
      --   -- register to copy classes to on selection
      --   register = [[*]],
      --   -- indicates what picker opens when running Telescope tailiscope
      --   -- can be any file inside of docs dir but most useful opts are
      --   -- all, base, categories, classes
      --   -- These are also accesible by running Telescope tailiscope <picker>
      --   default = "base",
      --   -- icon indicates an item which can be opened in tailwind docs
      --   -- can be icon or false
      --   doc_icon = "",
      --   -- if you would prefer to copy with/without class selector
      --   -- dot is maintained in display to differentiate class from other pickers
      --   no_dot = true,
      --   maps = {
      --     i = {
      --       -- back = "<C-h>",
      --       open_doc = "<C-o>",
      --     },
      --     n = {
      --       back = "<BS>",
      --       open_doc = "od",
      --     },
      --   },
      -- },
      -- live_grep_args = {
      --   auto_quoting = true, -- enable/disable auto-quoting
      --   -- define mappings, e.g.
      --   mappings = { -- extend mappings
      --     i = {
      --       ["<C-k>"] = lga_actions.quote_prompt(),
      --       ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
      --     },
      --     n = {
      --       ["<C-k>"] = lga_actions.quote_prompt(),
      --       ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
      --     },
      --   },
      --   -- ... also accepts theme settings, for example:
      --   -- theme = "dropdown", -- use dropdown theme
      --   -- theme = { }, -- use own theme spec
      --   -- layout_config = { mirror=true }, -- mirror preview pane
      -- },
      -- project = {
      --   patterns = { ".git", "Makefile", "package.json", "Gemfile" },
      -- },
    },
  }
end
