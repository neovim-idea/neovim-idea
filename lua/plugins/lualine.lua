return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup(require("neovim-idea.options").get_lualine_options())
  end,
}
