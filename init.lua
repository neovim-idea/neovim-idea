-- Bootstrap lazy.nvimgreen
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- load generic vim option, then some user defined overrides (if any), initialize neovim-idea's keymaps, and lazy
require("vim-options")
local ok, overrides = pcall(require, "overrides")
overrides = ok and overrides or {}
require("neovim-idea.keymaps").setup(overrides)
require("lazy").setup("plugins")
-- last but not least, setup the colorscheme!
vim.cmd.colorscheme(require("neovim-idea.options").get_colorscheme())
