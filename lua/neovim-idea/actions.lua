local Actions = {}

local dap = nil
local dapui = nil
local gitsigns_actions = nil

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
  assert(dap, "dap is nil, did you forget to set it?")
  dap.toggle_breakpoint()
end

function Actions.dap_continue()
  assert(dap, "dap is nil, did you forget to set it?")
  dap.continue()
end

function Actions.dapui_toggle()
  assert(dapui, "dapui is nil, did you forget to set it?")
  dapui.toggle()
end

function Actions.toggle_current_line_blame()
  assert(gitsigns_actions, "gitsigns_actions is nil, did you forget to set it?")
  gitsigns_actions.toggle_current_line_blame()
end

function Actions.setup(opts)
  dap = dap or opts.dap
  dapui = dapui or opts.dapui
  gitsigns_actions = gitsigns_actions or opts.gitsigns_actions
  return Actions
end

return Actions
