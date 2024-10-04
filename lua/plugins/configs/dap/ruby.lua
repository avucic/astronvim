local Job = require "plenary.job"
local dap = require "dap"
local in_progress

dap.adapters.ruby = function(callback, config)
  local port = config.debugPort or os.getenv "RUBY_DEBUG_PORT" or "12345"
  local host = config.debugHost or "127.0.0.1"
  local options = config.options or {}
  local timeout = options.timeout or 5000
  local current_line = vim.fn.line "."
  local script = config.script and config.script:gsub("${currentLine}", current_line)
  local executable = config.executable

  if config.request == "launch" then
    local command = executable and executable.command or "rdbg"
    local args = executable and executable.args or {}

    for i, v in pairs(executable.args) do
      v = v:gsub("${currentLine}", current_line)
      executable.args[i] = v
    end

    in_progress = false

    Job:new({
      command = command,
      detached = true,
      args = args,
      on_stdout = function(j, return_val) print("DEBUGGER stdout", return_val) end,
      on_stderr = function(j, return_val)
        print("DEBUtGGER stderr", return_val)
        if not in_progress then
          vim.defer_fn(function()
            callback { type = "server", host = host, port = port, options = options, timeout = timeout }
            in_progress = false
          end, 100)
        end
        in_progress = true
      end,
    }):start() -- or start()

    -- callback { type = "server", host = host, port = port, options = options }
  else
    print("RUBY DEBUGGER attach", port, host)
    callback { type = "server", host = host, port = port, options = options }
  end
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "Attach with rdbg (tcp 12345)",
    localfsMap = "/app:${workspaceFolder}",
    request = "attach",
    debugPort = "12345",
  },
  {
    type = "ruby",
    name = "Debug current spec",
    request = "launch",
    localfsMap = "/app:${workspaceFolder}",
    options = {
      initialize_timeout_sec = 5,
      initializeTimeoutSec = 5,
      timeout = 7000,
    },
    executable = {
      command = "docker",
      args = {
        "compose",
        "exec",
        "-i",
        "test",
        "rdbg",
        "--open",
        "--port",
        "12345",
        "--host",
        "0.0.0.0",
        "-c",
        "--",
        "bundle exec rspec ${relativeFile}:${currentLine}",
      },
    },
  },
  {
    type = "pwa-chrome",
    request = "launch",
    name = "Debug (Attach) Chrome",
    url = "https://localhost",
    webRoot = "${workspaceFolder}",
    port = 9222,
    protocol = "inspector",
    timeout = 30000,
    userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
    sourceMaps = true,
    sourceMapPathOverrides = {
      ["*"] = "${webRoot}/app/assets/builds/*",
    },
  },
}
