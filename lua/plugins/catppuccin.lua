return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      auto_integrations = true,
      custom_highlights = function(colors)
        return {
          FloatBorder = { bg = colors.crust },
          NormalBorder = { bg = colors.base },
        }
      end
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
