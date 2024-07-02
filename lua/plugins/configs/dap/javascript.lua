return function(dap)
  if not dap.adapters["pwa-chrome"] then
    dap.adapters["pwa-chrome"] = function(cb, config)
      local port = config.port or 9222
      local host = config.host or "localhost"
      cb {
        type = "server",
        host = host,
        port = port,
        executable = {
          command = "node",
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            port,
          },
        },
      }
    end
  end
end
