local dap = require "dap"

CurrentInput = ""

local exts = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
}

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      require("mason-registry").get_package("js-debug-adapter"):get_install_path() .. "/js-debug/src/dapdebugserver.js",
      "${port}",
    },
  },
}

dap.adapters["pwa-chrome"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      require("mason-registry").get_package("js-debug-adapter"):get_install_path() .. "/js-debug/src/dapdebugserver.js",
      "${port}",
    },
  },
}

for i, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Current Test File",
      autoAttachChildProcesses = true,
      skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      program = "${workspaceRoot}/node_modules/vitest/vitest.mjs",
      args = { "run", "${relativeFile}" },
      smartStep = true,
      console = "integratedTerminal",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node)",
      cwd = vim.fn.getcwd(),
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node with ts-node)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "--loader", "ts-node/esm" },
      runtimeExecutable = "node",
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    -- {
    --   type = "pwa-node",
    --   request = "launch",
    --   name = "Launch Current File (pwa-node with deno)",
    --   cwd = vim.fn.getcwd(),
    --   runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
    --   runtimeExecutable = "deno",
    --   attachSimplePort = 9229,
    -- },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with jest)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
      runtimeExecutable = "node",
      args = { "${file}", "--coverage", "false" },
      rootPath = "${workspaceFolder}",
      sourceMaps = true,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current File (pwa-node with vitest)",
      cwd = vim.fn.getcwd(),
      program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
      args = { "--inspect-brk", "--no-file-parallelism", "run", "${file}" },
      autoAttachChildProcesses = true,
      smartStep = true,
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },

    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Test Current Spec name (pwa-node with vitest)",
      cwd = vim.fn.getcwd(),
      program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
      -- args = { "--inspect-brk", "--no-file-parallelism", "-t",  "run", "${file}" },
      args = function()
        -- local current_line = vim.fn.line "."
        local argumentString = vim.fn.input("Spec name: ", CurrentInput)
        CurrentInput = argumentString
        return { "--inspect-brk", "--no-file-parallelism", "-t", CurrentInput, "run", "${file}" }
      end,
      autoAttachChildProcesses = true,
      smartStep = true,
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    -- {
    --   type = "pwa-node",
    --   request = "launch",
    --   name = "Launch Test Current File (pwa-node with deno)",
    --   cwd = vim.fn.getcwd(),
    --   runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
    --   runtimeExecutable = "deno",
    --   attachSimplePort = 9229,
    -- },
    -- {
    --   name = "Debug (Attach) - Remote",
    --   type = "pwa-chrome",
    --   request = "attach",
    --   -- program = "${file}",
    --   -- cwd = vim.fn.getcwd(),
    --   sourceMaps = true,
    --   --      reAttach = true,
    --   trace = true,
    --   -- protocol = "inspector",
    --   -- hostName = "127.0.0.1",
    --   port = 9222,
    --   webRoot = "${workspaceFolder}",
    -- },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch & Debug Chrome",
      url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({
            prompt = "Enter URL: ",
            default = "http://localhost:3000",
          }, function(url)
            if url == nil or url == "" then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end,
      webRoot = vim.fn.getcwd(),
      protocol = "inspector",
      sourceMaps = true,
      userDataDir = false,
    }, -- {
    --   type = "node2",
    --   request = "attach",
    --   name = "Attach Program (Node2)",
    --   processId = require("dap.utils").pick_process,
    -- },
    -- {
    --   type = "node2",
    --   request = "attach",
    --   name = "Attach Program (Node2 with ts-node)",
    --   cwd = vim.fn.getcwd(),
    --   sourceMaps = true,
    --   skipFiles = { "<node_internals>/**" },
    --   port = 9229,
    -- },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Program (pwa-node)",
      cwd = vim.fn.getcwd(),
      processId = require("dap.utils").pick_process,
      skipFiles = { "<node_internals>/**" },
    },
  }
end
