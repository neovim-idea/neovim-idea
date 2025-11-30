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
local actions = require("neovim-idea.actions")
vim.keymap.set(
  { "n", "i", "v" },
  "<M-D-CR>",
  actions.insert_line_above_cursor,
  { silent = true, desc = "Insert blank line above (enter insert mode)" }
)

vim.keymap.set(
  { "n", "i", "v" },
  "<D-CR>",
  actions.insert_line_below_cursor,
  { silent = true, desc = "Insert blank line below (enter insert mode)" }
)

vim.keymap.set({ "n", "i" }, "<M-Left>", actions.left_camel_hump, { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<M-Right>", actions.right_camel_hump, { noremap = true, silent = true })

-- Put this in your init.lua or a lua module you load

local function move_line_up()
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

local function move_line_down()
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

-- optional keymaps
vim.keymap.set({ "n", "i" }, "<D-S-Up>", move_line_up, { desc = "Move line up" })
vim.keymap.set({ "n", "i" }, "<D-S-Down>", move_line_down, { desc = "Move line down" })

-- Normal and Visual Mode
vim.keymap.set({ "n", "v" }, "<D-x>", '"+d', { noremap = true })
vim.keymap.set({ "n", "v" }, "<D-c>", '"+y', { noremap = true })
vim.keymap.set({ "n", "v" }, "<D-v>", '"+p', { noremap = true })

-- Insert Mode with return to Insert mode after action
vim.keymap.set("i", "<D-x>", '<Esc>"+d<D-i>', { noremap = true })
vim.keymap.set("i", "<D-c>", '<Esc>"+y<D-i>', { noremap = true })
vim.keymap.set("i", "<D-v>", '<Esc>"+p<D-i>', { noremap = true })

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
    if name == "" then
      return
    end
    if bo.buftype ~= "" then
      return
    end
    if not bo.modifiable or bo.readonly then
      return
    end

    -- Only write if modified; be quiet and resilient
    -- Use buf_call to ensure commands run in the right buffer context
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! update") -- update writes only if modified
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

vim.keymap.set(
  { "n", "i" },
  "<D-d>",
  duplicate_line_below_and_insert,
  { silent = true, desc = "Duplicate line below and insert" }
)

local function undo_preserve_mode()
  local mode = vim.api.nvim_get_mode().mode
  local function tc(keys)
    return vim.api.nvim_replace_termcodes(keys, true, false, true)
  end
  local function feed(keys)
    vim.api.nvim_feedkeys(tc(keys), "n", false)
  end

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
  vim.diagnostic.open_float(nil, { scope = "line" })
end

vim.keymap.set({ "n", "i" }, "<D-e>", show_lsp_error, { silent = true, desc = "show LSP errors in the current line" })

-- Function: run the existing `gcc` mapping (from Comment.nvim / commentary)
local function toggle_comment_line()
  -- use :normal (NOT :normal!) so mappings are honored
  vim.cmd("normal gcc")
end

-- Bindings
vim.keymap.set("n", "<D-/>", toggle_comment_line, { desc = "Toggle comment (line)", silent = true })

-- Visual mode: use the `gc` operator on the selection
vim.keymap.set("x", "<D-/>", "gc", { remap = true, silent = true, desc = "Toggle comment (selection)" })

-- (Optional) Insert mode: escape, toggle, then return to insert
vim.keymap.set("i", "<D-/>", "<Esc><Cmd>normal gcc<CR>a", { desc = "Toggle comment (line) from insert", silent = true })
