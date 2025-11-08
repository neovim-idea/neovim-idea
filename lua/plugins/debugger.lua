return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "watches", size = 0.15 },
            { id = "repl", size = 0.55 },
            { id = "scopes", size = 0.15 },
            { id = "stacks", size = 0.15 },
          },
          position = "bottom",
          size = 12,
        },
      },
      controls = {
        enabled = true,
        element = "stacks",
        icons = {
          play = "",
          pause = "󰏤",
          step_into = "⤵",
          step_over = "⤴",
          step_out = "⤶",
          step_back = "↶",
          run_last = "↻",
          terminate = "",
          disconnect = "⏏",
        },
      },
    })

    -- dap.listeners.before.attach.dapui_config = function()
    --   dapui.open({reset = true})
    -- end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open({ reset = true })
    end

    -- TODO apply catppuccin colors
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "󰺕", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "󰸞", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

    -- todo: bind a mouse-click over the gutter with a toggle-breakpoint action
    vim.keymap.set("n", "<D-b>", dap.toggle_breakpoint, { desc = "toggle line breakpoint" })
    vim.keymap.set("n", "<D-D>", dap.continue, { desc = "start / continue debugging" })
    vim.keymap.set("n", "<D-k4>", dapui.toggle, { desc = "toggle DAP UI" })
    vim.keymap.set("n", "<D-4>", dapui.toggle, { desc = "toggle DAP UI" })
    -- don't show the max width column
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "dapui_stacks",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_watches",
        "dapui_console",
        "dap-repl",
      },
      callback = function()
        vim.opt_local.colorcolumn = ""
      end,
    })
  end,
}
