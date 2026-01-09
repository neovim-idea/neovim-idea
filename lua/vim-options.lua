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

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- enable folding with treesitter
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldcolumn = "auto:1"
vim.opt.fillchars:append({
  foldopen = "",
  foldclose = "",
  foldsep = "│",
  fold = " ",
})

vim.o.cursorline = true

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
