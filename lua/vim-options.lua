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

-- keymaps
require("neovim-idea.keymaps").setup()

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
