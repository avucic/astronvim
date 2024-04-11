-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    local none_ls = require "null-ls"
    local formatting = none_ls.builtins.formatting
    local diagnostics = none_ls.builtins.diagnostics
    local code_actions = none_ls.builtins.code_actions
    local bundle_gemfile = os.getenv "BUNDLE_GEMFILE" or "~/.config/nvim/Gemfile"

    -- config variable is the default configuration table for the setup function call
    -- local none_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- none_ls.builtins.formatting.stylua,
      -- none_ls.builtins.formatting.prettier,

      formatting.erb_format.with {
        command = "bundle",
        args = {
          "exec",
          "erb-format",
          "--stdin",
        },
        env = {
          BUNDLE_GEMFILE = bundle_gemfile,
        },
      },

      diagnostics.erb_lint.with {
        command = "bundle",
        args = {
          "exec",
          "erblint",
          "--format",
          "json",
          "--stdin",
          "$FILENAME",
        },
        env = {
          BUNDLE_GEMFILE = bundle_gemfile,
        },
      },

      -- formatting.prettierd.with { extra_filetypes = { "html", "template", "json", "yaml" } },
      formatting.pg_format,
      code_actions.proselint,
    }
    return config -- return final config table
  end,
}
