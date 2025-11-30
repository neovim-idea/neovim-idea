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

local neotree_action = function(action)
  local original_buf = vim.api.nvim_get_current_buf()
  local modifiable = vim.api.nvim_buf_get_option(original_buf, "modifiable")
  if modifiable then
    vim.cmd("stopinsert")
  end
  vim.schedule(function()
    vim.cmd("Neotree " .. action)
  end)
end

function Actions.toggle_file_tree()
  neotree_action("toggle")
end

function Actions.reveal_in_file_tree()
  neotree_action("reveal")
end

function Actions.show_all_projects()
  vim.cmd("NeovimProjectDiscover")
end

function Actions.show_recent_projects()
  vim.cmd("NeovimProjectHistory")
end

function Actions.lsp_format_buffer()
  vim.lsp.buf.format()
end

function Actions.toggle_terminal()
  require("snacks").terminal(nil, { position = "bottom" })
end

function Actions.find_files()
  require("telescope.builtin").find_files()
end

function Actions.fuzzy_find_in_files()
  require("telescope.builtin").live_grep()
end

function Actions.left_camel_hump()
  local ch = require("custom_plugins.camel-humps")
  local current_cursor_position = vim.api.nvim_win_get_cursor(0)
  local current_line = vim.fn.getline(".")
  local cursor_col = current_cursor_position[2]
  local newpos = ch.left_camel_hump(current_line:sub(0, cursor_col))
  local new_cursor_col = newpos.cursor_col or #(vim.fn.getline(vim.fn.line(".") - 1))
  vim.api.nvim_win_set_cursor(0, { current_cursor_position[1] + newpos.cursor_line, new_cursor_col })
end

function Actions.right_camel_hump()
  local ch = require("custom_plugins.camel-humps")
  local current_cursor_position = vim.api.nvim_win_get_cursor(0)
  local current_line = vim.fn.getline(".")
  local cursor_col = current_cursor_position[2]
  local line_to_be_processed = current_line:sub(cursor_col + 1, #current_line)
  local line_count = vim.api.nvim_buf_line_count(0)
  local newpos = ch.right_camel_hump(line_to_be_processed)

  local new_cursor_col = nil
  local new_cursor_line = current_cursor_position[1] + newpos.cursor_line

  if newpos.cursor_col == nil then
    -- we need to move to the next line.. but do we have a new one?
    if new_cursor_line >= line_count then
      new_cursor_line = line_count
      new_cursor_col = #current_line
    else
      new_cursor_col = 0
    end
  else
    new_cursor_col = cursor_col + newpos.cursor_col
  end

  vim.api.nvim_win_set_cursor(0, { new_cursor_line, new_cursor_col })
end

function Actions.setup(opts)
  dap = dap or opts.dap
  dapui = dapui or opts.dapui
  gitsigns_actions = gitsigns_actions or opts.gitsigns_actions
  return Actions
end

return Actions
