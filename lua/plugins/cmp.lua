return {
  {
    "Saghen/blink.cmp",
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    dependencies = {
      --   "saadparwaiz1/cmp_luasnip",
      --   "hrsh7th/cmp-buffer",
      --   "hrsh7th/cmp-path",
      --   "hrsh7th/cmp-nvim-lsp",
      --
      -- "hrsh7th/cmp-emoji",
      -- "f3fora/cmp-spell",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "dmitmel/cmp-cmdline-history",
    },
    event = { "User AstroFile" },
    opts = function(_, opts)
      local cmp = require "cmp"

      require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/nvim/vsnip" } }
      require "codeium"
      require "crates"
      local lspkind = require "lspkind"

      -- opts.snippet = {
      --   expand = function(args) luasnip.lsp_expand(args.body) end,
      -- }

      opts.mapping = {
        -- ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<c-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- elseif vim.fn["vsnip#available"](1) == 1 then
            --   feedkey("<Plug>(vsnip-expand-or-jump)", "")
            -- elseif has_words_before() then
            --   cmp.complete()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<c-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
            -- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            --   feedkey("<Plug>(vsnip-jump-prev)", "")
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
        ["<Tab>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        -- ["<esc>"] = cmp.mapping.close(),
      }

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      --
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.insert {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- elseif vim.fn["vsnip#available"](1) == 1 then
            --   feedkey("<Plug>(vsnip-expand-or-jump)", "")
            -- elseif has_words_before() then
            --   cmp.complete()
            else
              fallback()
            end
          end, { "i", "s", "c" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            -- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            --   feedkey("<Plug>(vsnip-jump-prev)", "")
            else
              fallback()
            end
          end, { "i", "s", "c" }),
          ["<c-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- elseif vim.fn["vsnip#available"](1) == 1 then
            --   feedkey("<Plug>(vsnip-expand-or-jump)", "")
            -- elseif has_words_before() then
            --   cmp.complete()
            else
              fallback()
            end
          end, { "i", "s", "c" }),
          ["<c-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            -- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            --   feedkey("<Plug>(vsnip-jump-prev)", "")
            else
              fallback()
            end
          end, { "i", "s", "c" }),
        },
        sources = {
          { name = "cmdline_history" },
          { name = "path" },
          { name = "cmdline", option = { ignore_cmds = { "!" } } },
        },
      })
      -- opts.formatting = {
      --   format = function(entry, vim_item)
      --     -- if you have lspkind installed, you can use it like
      --     -- in the following line:
      --     vim_item.kind = require("lspkind").symbolic(vim_item.kind, { mode = "symbol_text" })
      --     -- vim_item.menu = source_mapping[entry.source.name]
      --
      --     if entry.source.name == "codeium" then
      --       local detail = (entry.completion_item.data or {}).detail
      --       vim_item.kind = " Codeium"
      --       if detail and detail:find ".*%%.*" then vim_item.kind = vim_item.kind .. " " .. detail end
      --
      --       if (entry.completion_item.data or {}).multiline then vim_item.kind = vim_item.kind .. " " .. "[ML]" end
      --     end
      --     local maxwidth = 80
      --     vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
      --     return vim_item
      --   end,
      -- }

      opts.formatting = {
        format = function(entry, vim_item)
          -- Set up lspkind icons
          vim_item.kind = require("lspkind").symbolic(vim_item.kind, { mode = "symbol_text" })

          -- Set up nvim-web-devicons
          if entry.source.name == "nvim_lsp" then
            local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
            if icon then
              vim_item.kind = icon .. " " .. vim_item.kind
              vim_item.kind_hl_group = hl_group
            end

            if (entry.completion_item.data or {}).multiline then vim_item.kind = vim_item.kind .. " " .. "[ML]" end
          end

          return vim_item
        end,
      }

      -- opts.formatting = {
      --   format = function(entry, vim_item)
      --     vim_item.menu = ({
      --       nvim_lsp = "[LSP]",
      --       vsnip = "[Snippet]",
      --       luavsnip = "[Snippet]",
      --       nvim_lua = "[Nvim Lua]",
      --       buffer = "[Buffer]",
      --       codium = "[Codium]",
      --     })[entry.source.name]
      --
      --     -- vim_item.dup = ({
      --     --   vsnip = 0,
      --     --   nvim_lsp = 0,
      --     --   nvim_lua = 0,
      --     --   buffer = 0,
      --     --   codium = 0,
      --     -- })[entry.source.name] or 0
      --
      --     return vim_item
      --   end,
      -- }
      opts.completion = {
        completeopt = "menu,menuone,preview,noselect",
      }
      --
      -- opts.snippet = {
      --   expand = function(args) luasnip.lsp_expand(args.body) end,
      -- }
      --
      --

      -- local source_map = {
      --   buffer = "Buffer",
      --   nvim_lsp = "LSP",
      --   nvim_lsp_signature_help = "Signature",
      --   luasnip = "LuaSnip",
      --   nvim_lua = "Lua",
      --   path = "Path",
      --   copilot = "Copilot",
      -- }
      -- local function ltrim(s) return s:match "^%s*(.*)" end
      -- opts.formatting = {
      --   fields = { "kind", "abbr", "menu" },
      --   format = lspkind.cmp_format {
      --     mode = "symbol",
      --     -- See: https://www.reddit.com/r/neovim/comments/103zetf/how_can_i_get_a_vscodelike_tailwind_css/
      --     before = function(entry, vim_item)
      --       -- Replace the 'menu' field with the kind and source
      --       vim_item.menu = "  " .. vim_item.kind .. " (" .. (source_map[entry.source.name] or entry.source.name) .. ")"
      --       vim_item.menu_hl_group = "SpecialComment"
      --
      --       vim_item.abbr = ltrim(vim_item.abbr)
      --
      --       if vim_item.kind == "Color" and entry.completion_item.documentation then
      --         local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
      --         if r then
      --           local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
      --           local group = "Tw_" .. color
      --           if vim.fn.hlID(group) < 1 then vim.api.nvim_set_hl(0, group, { fg = "#" .. color }) end
      --           vim_item.kind_hl_group = group
      --           return vim_item
      --         end
      --       end
      --
      --       return vim_item
      --     end,
      --   },
      -- }
      --
      -- opts.sources = {
      --   { name = "codeium" },
      --   { name = "nvim_lsp" },
      --   { name = "buffer" },
      --   { name = "luasnip" },
      --   { name = "crates" },
      -- }

      opts.sources = cmp.config.sources({
        { name = "codeium" }, -- For luasnip users.
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }, {})

      -- TODO; wha
      -- table.insert(opts.sources, { name = "spell" })
      -- table.insert(opts.sources, { name = "codeium" })
      -- local sources = opts.sources
      -- for i = #sources, 1, -1 do
      --   print(sources[i].name)
      --   if sources[i].name == "emmet_ls" then table.remove(sources, i) end
      -- end
      -- table.insert(opts.sources, { name = "luasnip", group_index = 2 })
      -- table.insert(opts.sources, { name = "emoji", priority = 20000 })
      -- opts.duplicates.luasnip = 1

      return opts
    end,
  },
  {
    "jcdickinson/codeium.nvim",
    event = { "User AstroFile" },
    config = function() require("codeium").setup {} end,
  },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    config = function() require("crates").setup() end,
  },
}
