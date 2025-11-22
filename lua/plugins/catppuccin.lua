return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local catppuccin = require("catppuccin")
    local path = vim.fn.expand("~/.config/nvim/lua/catppuccin/palettes/")
    local files = vim.fn.globpath(path, "*", false, true)
    for i, file in ipairs(files) do
      catppuccin.flavours[vim.fn.fnamemodify(file, ":t:r")] = 4 + i
    end

    catppuccin.setup(require("neovim-idea.options").get_catppuccin_options())
  end,
}
