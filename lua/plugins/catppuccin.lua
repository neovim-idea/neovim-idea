return {
  "neovim-idea/catppuccin-reloaded-nvim",
  dependencies = { "catppuccin/nvim" },
  priority = 1000,
  config = function()
    require("catppuccin-reloaded").setup({ catppuccin = require("neovim-idea.options").get_catppuccin_options() })
  end,
}
