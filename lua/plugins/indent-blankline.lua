return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("ibl").setup({
      scope = { enabled = false },
      indent = { char = "│" },
    })
    -- local palette = require("catppuccin.palettes").get_palette()
    -- vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = palette.surface0 })
  end,
}
