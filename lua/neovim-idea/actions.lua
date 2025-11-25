local Actions = {}

local dap = nil
local dapui = nil

function Actions.insert_line_above_cursor()
  vim.cmd("normal! O")
  vim.defer_fn(function()
    vim.cmd("startinsert!")
  end, 10)
end

function Actions.insert_line_below_cursor()
  vim.cmd("normal! o")
  vim.defer_fn(function()
    vim.cmd("startinsert!")
  end, 10)
end

function Actions.dap_toggle_breakpoint()
  assert(dap ~= nil, "dap is nil, did you forget to set it?")
  dap.toggle_breakpoint()
end

function Actions.dap_continue()
  assert(dap ~= nil, "dap is nil, did you forget to set it?")
  dap.continue()
end

function Actions.dapui_toggle()
  assert(dapui ~= nil, "dap is nil, did you forget to set it?")
  dapui.toggle()
end

function Actions.setup(opts)
  dap = opts.dap
  dapui = opts.dapui
  return Actions
end

return Actions
