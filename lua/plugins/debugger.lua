return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local actions = require("neovim-idea.actions").setup({
      dap = dap,
      dapui = dapui,
    })

    dapui.setup(require("neovim-idea.options").get_nvim_dap_ui_options())

    -- dap.listeners.before.attach.dapui_config = function()
    --   dapui.open({reset = true})
    -- end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open({ reset = true })
    end

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "󰺕", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "󰸞", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

    vim.keymap.set("n", "<D-b>", actions.dap_toggle_breakpoint, { desc = "toggle line breakpoint" })
    vim.keymap.set("n", "<D-D>", actions.dap_continue, { desc = "start / continue debugging" })
    vim.keymap.set("n", "<D-k4>", actions.dapui_toggle, { desc = "toggle DAP UI" })
    vim.keymap.set("n", "<D-4>", actions.dapui_toggle, { desc = "toggle DAP UI" })
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
