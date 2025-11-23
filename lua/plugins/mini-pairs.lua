return {
  "nvim-mini/mini.pairs",
  version = "*",
  config = function()
    require("mini.pairs").setup(require("neovim-idea.options").get_mini_pairs_options())
  end,
}
