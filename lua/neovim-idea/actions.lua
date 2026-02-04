local Actions = {}

local dap = nil
local dapui = nil
local gitsigns_actions = nil
local camelhumps = nil
local snacks = nil

local function is_normal_mode()
  local mode = vim.api.nvim_get_mode().mode
  return mode:sub(1, 1) == "n"
end

local function is_insert_mode()
  local mode = vim.api.nvim_get_mode().mode
  return mode:sub(1, 1) == "i"
end

local function is_visual_mode()
  local mode = vim.api.nvim_get_mode().mode
  return (mode == "v" or mode == "V" or mode == "\22" or mode == "s" or mode == "S" or mode == "\19")
end

--[[Public API]]
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

function Actions.git_toggle_current_line_blame()
  assert(gitsigns_actions, "gitsigns_actions is nil, did you forget to set it?")
  gitsigns_actions.toggle_current_line_blame()
end

function Actions.git_current_file_blame()
  vim.cmd("Git blame")
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

function Actions.show_in_file_tree()
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

function Actions.search_in_files()
  require("telescope.builtin").live_grep()
end

function Actions.move_line_up()
  if vim.bo.readonly or not vim.bo.modifiable then
    vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    return
  end
  local bufnr = 0
  local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- row: 1-based
  if row == 1 then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, row - 2, row, false) -- prev, curr
  local prev, curr = lines[1], lines[2]
  vim.api.nvim_buf_set_lines(bufnr, row - 2, row, false, { curr, prev })
  vim.api.nvim_win_set_cursor(0, { row - 1, math.min(col, #curr) })
end

function Actions.move_line_down()
  if vim.bo.readonly or not vim.bo.modifiable then
    vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    return
  end
  local bufnr = 0
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local last = vim.api.nvim_buf_line_count(bufnr)
  if row == last then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, row - 1, row + 1, false) -- curr, next
  local curr, nextl = lines[1], lines[2]
  vim.api.nvim_buf_set_lines(bufnr, row - 1, row + 1, false, { nextl, curr })
  vim.api.nvim_win_set_cursor(0, { row + 1, math.min(col, #curr) })
end

function Actions.smart_cut()
  local command
  if is_visual_mode() then
    command = 'normal! "+d'
  else
    command = is_insert_mode() and 'stopinsert | normal! "+dd' or 'normal! "+dd'
  end
  vim.cmd(command)
end

function Actions.smart_copy()
  local command
  if is_visual_mode() then
    command = 'normal! "+y'
  else
    command = is_insert_mode() and 'stopinsert | normal! "+yy' or 'normal! "+yy'
  end
  vim.cmd(command)
end

function Actions.smart_paste()
  local command
  if is_visual_mode() then
    command = 'normal! "+p`]'
  else
    command = is_insert_mode() and 'stopinsert | normal! "+gP' or 'normal! "+gP'
  end
  vim.cmd(command)
end

function Actions.duplicate_line_below()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1] or ""
  vim.api.nvim_buf_set_lines(0, row, row, true, { line })
  vim.api.nvim_win_set_cursor(0, { row + 1, #line })
end

function Actions.undo()
  local mode = vim.api.nvim_get_mode().mode
  if mode:match("^n") then
    return "u"
  elseif mode:match("^i") or mode:match("^R") then
    return "<C-o>u"
  elseif mode:match("^[vV\22]") then
    return "<Esc>u" .. "gv"
  else
    return "u"
  end
end

function Actions.lsp_show_diagnostics()
  vim.diagnostic.open_float(nil, { scope = "line" })
end

function Actions.jump_left()
  assert(camelhumps, "camelhumps is nil, did you forget to set it?")
  camelhumps.left()
end

function Actions.jump_right()
  assert(camelhumps, "camelhumps is nil, did you forget to set it?")
  camelhumps.right()
end

function Actions.delete_left()
  assert(camelhumps, "camelhumps is nil, did you forget to set it?")
  camelhumps.left_delete()
end

function Actions.delete_right()
  assert(camelhumps, "camelhumps is nil, did you forget to set it?")
  camelhumps.right_delete()
end

function Actions.rename_symbol()
  return ":IncRename " .. vim.fn.expand("<cword>")
end

function Actions.git_preview_hunk()
  assert(gitsigns_actions, "gitsigns_actions is nil, did you forget to set it?")
  gitsigns_actions.preview_hunk()
end

function Actions.git_undo_hunk()
  assert(gitsigns_actions, "gitsigns_actions is nil, did you forget to set it?")
  gitsigns_actions.reset_hunk()
end

function Actions.show_lazygit()
  assert(snacks, "snacks is nil, did you forget to set it?")
  snacks.lazygit.open()
end

function Actions.show_keymaps()
  require("which-key").show({ global = true })
end

function Actions.toggle_comment()
  if is_normal_mode() then
    vim.cmd("normal gcc")
  elseif is_visual_mode() then
    vim.cmd("normal gc")
  elseif is_insert_mode() then
    vim.cmd("normal gcc")
    vim.cmd("startinsert")
  end
end

function Actions.close_current_buffer()
  local ok, utils = pcall(require, "switcher-nvim.utils")
  if ok then
    local buffers = utils.available_buffers()
    if #buffers >= 2 then
      vim.api.nvim_buf_delete(buffers[1].bufnr, { force = false })
      vim.api.nvim_set_current_buf(buffers[2].bufnr)
    end
    return
  end

  -- fallback: just close the current buffer
  vim.api.nvim_buf_delete(0, { force = false })
end

function Actions.run_codelens()
  vim.lsp.codelens.run()
end

function Actions.debug_keys_pressed()
  vim.api.nvim_echo({ { "Listening for next keypress...", "Question" } }, true, {})
  local raw_key_input = vim.fn.getcharstr()
  local readable_key_name = vim.fn.keytrans(raw_key_input)
  vim.api.nvim_echo({ { "Neovim sees that as: ", "None" }, { readable_key_name, "Function" } }, true, {})
end

function Actions.setup(opts)
  dap = dap or opts.dap
  dapui = dapui or opts.dapui
  gitsigns_actions = gitsigns_actions or opts.gitsigns_actions
  camelhumps = camelhumps or opts.camelhumps
  snacks = snacks or opts.snacks
  return Actions
end

return Actions
