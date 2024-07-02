local dap = require "dap"
local js_based_languages = { "typescript", "javascript", "typescriptreact" }

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "suketa/nvim-dap-ruby", config = false, enabled = false },
      {
        "microsoft/vscode-chrome-debug",
        enabled = false,
        config = function()
          require("dap-vscode-js").setup {
            debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
            debugger_cmd = { "js-debug-adapter" },
            adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
          }
        end,
      },
    },
    config = function()
      require("dap.ext.vscode").load_launchjs(nil, {
        ["ruby"] = { "rails", "ruby" },
        ["pwa-node"] = js_based_languages,
        ["node"] = js_based_languages,
        ["chrome"] = js_based_languages,
        ["pwa-chrome"] = js_based_languages,
      })
      require "plugins.configs.dap.ruby"(dap)
      require "plugins.configs.dap.javascript"(dap)
    end,
  },
}
