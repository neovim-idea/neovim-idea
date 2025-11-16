-- Bootstrap lazy.nvimgreen 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- enable folding with treesitter
vim.o.foldenable = true 
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldcolumn = "auto"
vim.opt.fillchars:append({
  foldopen = "",
  foldclose = "",
  foldsep = "│",
  fold = " ",
})

vim.o.cursorline = true

-- avoid scrolling all the way to the botttom, up to the point where the last line is on the top of the editor
vim.o.scrolloff = 999

require("vim-options")
require("lazy").setup("plugins")

-- debug stuff to print keystrokes
local function listen_for_key()
  vim.api.nvim_echo({ { "Listening for next keypress...", "Question" } }, true, {})

  local raw_key_input = vim.fn.getcharstr()
  local readable_key_name = vim.fn.keytrans(raw_key_input)
  vim.api.nvim_echo({ { "Neovim sees that as: ", "None" }, { readable_key_name, "Function" } }, true, {})
end

-- Map the function to the <F5> key in normal mode.
vim.keymap.set("n", "<F5>", listen_for_key, {
  noremap = true,
  silent = true,
  desc = "Listen for a key and print its representation",
})
