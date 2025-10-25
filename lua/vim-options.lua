-- some sane defaults on tabs & identation
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")

-- line margin, wrapping and colors
vim.opt.termguicolors = true
vim.opt.textwidth = 120
vim.opt.colorcolumn = "+1"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2"
vim.opt.showbreak = "↳"
vim.api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine" })

-- NOTE When refactoring the keymaps, keep in mind that:
--    1. use `remap = true` when the RHS are keys that could hit another mapping
--    2. use `silent = true` when you want to run functions quietly (no `echo`es, nor "Press Enter" prompts, etc..)


-- cursor style
-- vim.opt.guicursor = "a:ver1-blinkwait700-blinkon400-blinkoff250"

-- keymaps
-- insert lines above/below
vim.keymap.set({ "n", "i", "v" }, "<M-D-CR>", function()
  vim.cmd("normal! O")
  vim.defer_fn(function()
    vim.cmd("startinsert!")
  end, 10)
end, { silent = true, desc = "Insert blank line above (enter insert mode)" })

vim.keymap.set({ "n", "i", "v" }, "<D-CR>", function()
  vim.cmd("normal! o")
  vim.defer_fn(function()
    vim.cmd("startinsert!")
  end, 10)
end, { silent = true, desc = "Insert blank line below (enter insert mode)" })

-- cycle through open buffers
-- todo: when leaving a text buffer, save it to disk
function cycle_buffers()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local current_buf = vim.fn.bufnr("%")

  local found_current_buf = false
  for _, buf in ipairs(bufs) do
    if found_current_buf then
      vim.cmd("buffer " .. buf.bufnr)
      return
    end
    if buf.bufnr == current_buf then
      found_current_buf = true
    end
  end
  -- If we reached the end of the buffer list, cycle back to the first one
  if bufs[1] then
    vim.cmd("buffer " .. bufs[1].bufnr)
  end
end

-- Map CTRL-TAB to cycle through open buffers
vim.keymap.set({ "n", "i" }, "<C-Tab>", cycle_buffers, { noremap = true, silent = true })

local C = require("custom_plugins.camel-humps")
vim.keymap.set({ "n", "i" }, "<S-Left>", function()
  local current_cursor_position = vim.api.nvim_win_get_cursor(0) -- Get current cursor position
  local current_line = vim.fn.getline(".") -- Get the current line content
  local cursor_col = current_cursor_position[2] -- Get the cursor column position
  local newpos = C.left_camel_hump(current_line:sub(0, cursor_col))
  local new_cursor_col = newpos.cursor_col or #(vim.fn.getline(vim.fn.line('.') - 1))
  vim.api.nvim_win_set_cursor(0, { current_cursor_position[1] + newpos.cursor_line , new_cursor_col})
end, { noremap = true, silent = true })

function camel_humps_shift_right()
  local current_pos = vim.api.nvim_win_get_cursor(0) -- Get current cursor position
  local line_num = current_pos[1]
  local current_line = vim.fn.getline(".") -- Get the current line content
  local cursor_col = current_pos[2] + 1 -- Get the cursor column position (0 based)
  local line_len = #current_line
  local function is_upper_at(i)
    if i < 1 or i > line_len then
      return false
    end
    local ch = current_line:sub(i, i)
    return ch:match("%u") ~= nil
  end

  -- If we're at the end of the line, and not in the last line, move to the next line end
  if (cursor_col == line_len and line_num < vim.fn.line("$")) or (current_line == "") then
    vim.api.nvim_win_set_cursor(0, { line_num + 1, 0 })
    return
  end

  -- Save the current position of the cursor
  local current_cursor_position = vim.api.nvim_win_get_cursor(0)

  -- 1. TODO Find the leftmost UPPERCASE word after the cursor
  local closest_uppercase_position = nil
  local current_char = current_line:sub(cursor_col, cursor_col)
  if current_char:match("%u") ~= nil then
    -- if we're over an uppercase char, try to understand if we're inside an uppercase word
    local _, end_pos = current_line:find("[%u%d]+", cursor_col)
    -- now, try to search another uppercase word, starting from the previous uppercase end_position + 1
    local start_pos, ep = current_line:find("[%u%d]+", end_pos + 1)
    closest_uppercase_position = (start_pos or line_len) - 1
  --    local first_substring = current_line:sub(cursor_col, end_pos)
  --    local second_substring
  --    if start_pos ~= nil then
  --      second_substring = current_line:sub(start_pos, ep)
  --    else
  --      second_substring = "-"
  --    end
  --    print(current_char .. " -> " .. first_substring .. " -> " .. second_substring)
  else
    closest_uppercase_position = (current_line:find("%u", cursor_col) or line_len) - 1
  end

  -- 2. Find the leftmost special character after the cursor
  local closest_special_character_position = nil
  --[[
  if current_char:match("[(%)%.%=~?|&+%-*:/!<>#_]") ~= nil then
    -- if we're over an uppercase char, try to understand if we're inside an uppercase word
    local _, end_pos = current_line:find("[(%)%.%=~?|&+%-*:/!<>#_]+", cursor_col + 1)
    -- now, try to search another uppercase word, starting from the previous uppercase end_position + 1
    local start_pos, ep = current_line:find("[(%)%.%=~?|&+%-*:/!<>#_]+", end_pos + 1)
      closest_special_character_position = start_pos - 1
--    local first_substring = current_line:sub(cursor_col, end_pos)
--    local second_substring
--    if start_pos ~= nil then
--      second_substring = current_line:sub(start_pos, ep)
--    else
--      second_substring = "-"
--    end
--    print(current_char .. " -> " .. first_substring .. " -> " .. second_substring)
  else
    closest_special_character_position = current_line:find("[(%)%.%=~?|&+%-*:/!<>#_]", cursor_col) - 1
  end
  --]]
  for i = cursor_col + 1, line_len do
    local char = current_line:sub(i, i)
    if is_special_char(char) then
      closest_special_character_position = i - 1
      -- Now continue left to find the rest of the uppercase word
      --      for j = i + 1, line_len do
      --        local next_char = current_line:sub(j, j)
      --        if not is_special_char(next_char) then
      --          break
      --        end
      --        closest_special_character_position = j
      --      end
      break
    end
  end

  -- 3. TODO update description Find the rightmost word (sequence of alphanumeric characters)
  local closest_word_start_position = nil
  for i = cursor_col + 1, line_len do
    local char = current_line:sub(i, i)
    if char:match("[a-zA-Z0-9]") then
      closest_word_start_position = i
    elseif not char:match("[a-zA-Z0-9]") then
      break
    end
  end

  -- 4. If all positions are nil, set final_position to the start of the current line
  local final_position = math.min(
    closest_uppercase_position or line_len,
    closest_special_character_position or line_len,
    closest_word_start_position or line_len
  )

  -- 5. Move the cursor to the calculated final position
  vim.api.nvim_win_set_cursor(0, { current_cursor_position[1], final_position })
end

-- Map Shift+Right in normal/insert modes to the rightward camel-hump motion
vim.keymap.set({ "n", "i" }, "<S-Right>", function()
  camel_humps_shift_right()
end, { noremap = true, silent = true })


-- Put this in your init.lua or a lua module you load

local function move_line_up()
  if vim.bo.readonly or not vim.bo.modifiable then
    vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    return
  end
  local bufnr = 0
  local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- row: 1-based
  if row == 1 then return end

  local lines = vim.api.nvim_buf_get_lines(bufnr, row-2, row, false) -- prev, curr
  local prev, curr = lines[1], lines[2]
  vim.api.nvim_buf_set_lines(bufnr, row-2, row, false, { curr, prev })
  vim.api.nvim_win_set_cursor(0, { row-1, math.min(col, #curr) })
end

local function move_line_down()
  if vim.bo.readonly or not vim.bo.modifiable then
    vim.notify("Buffer is not modifiable", vim.log.levels.WARN)
    return
  end
  local bufnr = 0
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local last = vim.api.nvim_buf_line_count(bufnr)
  if row == last then return end

  local lines = vim.api.nvim_buf_get_lines(bufnr, row-1, row+1, false) -- curr, next
  local curr, nextl = lines[1], lines[2]
  vim.api.nvim_buf_set_lines(bufnr, row-1, row+1, false, { nextl, curr })
  vim.api.nvim_win_set_cursor(0, { row+1, math.min(col, #curr) })
end

-- optional keymaps
vim.keymap.set({"n", "i"}, "<D-S-Up>", move_line_up,   { desc = "Move line up" })
vim.keymap.set({"n", "i"}, "<D-S-Down>", move_line_down, { desc = "Move line down" })

-- Normal and Visual Mode
vim.keymap.set({'n', 'v'}, '<D-x>', '"+d', { noremap = true })
vim.keymap.set({'n', 'v'}, '<D-c>', '"+y', { noremap = true })
vim.keymap.set({'n', 'v'}, '<D-v>', '"+p', { noremap = true })

-- Insert Mode with return to Insert mode after action
vim.keymap.set('i', '<D-x>', '<Esc>"+d<D-i>', { noremap = true })
vim.keymap.set('i', '<D-c>', '<Esc>"+y<D-i>', { noremap = true })
vim.keymap.set('i', '<D-v>', '<Esc>"+p<D-i>', { noremap = true })

-- Autosave on buffer "blur" if the buffer is writeable
local group = vim.api.nvim_create_augroup("AutoSaveOnBlur", { clear = true })
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = group,
  pattern = "*",
  callback = function(ev)
    local buf = ev.buf
    -- Skip special/readonly buffers and unnamed buffers
    local name = vim.api.nvim_buf_get_name(buf)
    local bo = vim.bo[buf]
    if name == "" then return end
    if bo.buftype ~= "" then return end
    if not bo.modifiable or bo.readonly then return end

    -- Only write if modified; be quiet and resilient
    -- Use buf_call to ensure commands run in the right buffer context
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! update")  -- update writes only if modified
    end)
  end,
})

local function duplicate_line_below_and_insert()
  local win = 0
  local buf = 0
  local pos = vim.api.nvim_win_get_cursor(win) -- {row (1-based), col (0-based bytes)}
  local row1, col0 = pos[1], pos[2]
  local row0 = row1 - 1

  local line = vim.api.nvim_buf_get_lines(buf, row0, row0 + 1, true)[1] or ""
  -- insert the same line *below*
  vim.api.nvim_buf_set_lines(buf, row0 + 1, row0 + 1, true, { line })

  -- move cursor to the duplicated line, same column (clamped to line length)
  local newcol = math.min(col0, #line)
  vim.api.nvim_win_set_cursor(win, { row1 + 1, newcol })

  -- enter insert mode
  vim.cmd("startinsert")
end

vim.keymap.set({ "n", "i" }, "<D-d>", duplicate_line_below_and_insert, { silent = true, desc = "Duplicate line below and insert" })

local function undo_preserve_mode()
  local mode = vim.api.nvim_get_mode().mode
  local function tc(keys) return vim.api.nvim_replace_termcodes(keys, true, false, true) end
  local function feed(keys) vim.api.nvim_feedkeys(tc(keys), "n", false) end

  if mode:match("^n") then
    -- Normal
    feed("u")
  elseif mode:match("^i") or mode:match("^R") then
    -- Insert or Replace/Virtual-Replace: do one normal command, pop back to insert/replace
    feed("<C-o>u")
  elseif mode:match("^[vV\22]") then
    -- Visual/Line/Block: leave visual, undo, then reselect
    feed("<Esc>u" .. "gv")
  else
    -- Fallback (operator-pending, etc.)
    feed("u")
  end
end

-- Map Command+Z in the modes Neovim accepts. (Replace is covered by "i")
vim.keymap.set({ "n", "i", "v", "x", "s" }, "<D-z>", undo_preserve_mode, {
  silent = true,
  desc = "Undo (preserve current mode)",
})

local function show_lsp_error()
  vim.diagnostic.open_float(nil, {scope = "line"})
end

vim.keymap.set({"n", "i"}, "<D-e>", show_lsp_error, {silent = true, desc = "show LSP errors in the current line"})

-- Function: run the existing `gcc` mapping (from Comment.nvim / commentary)
local function toggle_comment_line()
  -- use :normal (NOT :normal!) so mappings are honored
  vim.cmd('normal gcc')
end

-- Bindings
vim.keymap.set('n', '<D-/>', toggle_comment_line, { desc = 'Toggle comment (line)', silent = true })

-- Visual mode: use the `gc` operator on the selection
vim.keymap.set('x', '<D-/>', 'gc', { remap = true, silent = true, desc = 'Toggle comment (selection)' })

-- (Optional) Insert mode: escape, toggle, then return to insert
vim.keymap.set('i', '<D-/>', '<Esc><Cmd>normal gcc<CR>a',
  { desc = 'Toggle comment (line) from insert', silent = true })
