return {
  {
    "mfussenegger/nvim-dap",
    desc = "Debugging support for TypeScript in Node.js",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- Added missing dependency
      "jay-babu/mason-nvim-dap.nvim", -- Use Mason for managing DAP
      "mxsdev/nvim-dap-vscode-js", -- Added for VSCode JS Debugging
    },

    keys = {
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Set conditional breakpoint",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue debugging",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Toggle DAP UI",
      },
    },

    config = function()
      local dap = require("dap")

      -- Setup dap-vscode-js
      require("dap-vscode-js").setup({
        node_path = "node",
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        debugger_cmd = {
          "node",
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
        },
        adapters = {
          type = "server",
          host = "127.0.0.1",
        },
      })

      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch TypeScript File",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          runtimeExecutable = "ts-node",
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Node Process",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
        },
      }

      require("dapui").setup()

      local dapui = require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
