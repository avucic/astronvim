return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      --   "saadparwaiz1/cmp_luasnip",
      --   "hrsh7th/cmp-buffer",
      --   "hrsh7th/cmp-path",
      --   "hrsh7th/cmp-nvim-lsp",
      --
      "hrsh7th/cmp-emoji",
      -- "f3fora/cmp-spell",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
    },
    event = { "User AstroFile" },
    opts = function(_, opts)
      local cmp = require "cmp"
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.vsnip" } }
      require "codeium"
      require "crates"

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
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
      -- table.insert(opts.sources, { name = "spell" })
      table.insert(opts.sources, { name = "codeium", group_index = 1, priority = 600 })

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
