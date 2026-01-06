return {
  "neovim-idea/camelhumps-nvim",
  lazy = false,
  config = function()
    require("neovim-idea.actions").setup({ camelhumps = require("camelhumps") })
  end,
}
