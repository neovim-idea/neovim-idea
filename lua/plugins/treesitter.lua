return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- TODO figure out where the settings went, when moving to "main"
  branch = "master",
  lazy = false,
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup(require("neovim-idea.options").get_nvim_treesitter_options())
  end,
}
