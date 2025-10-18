return {
  "nvim-mini/mini.indentscope",
  version = "*",
  dependencies = {},
  config = function()
    require("mini.indentscope").setup({
      draw = {
        highlight = "MiniIndentscopeSymbol",
      },
      symbol = "│",
    })
    -- indentation guidelines match catppuccin color scheme
    local palette = require("catppuccin.palettes").get_palette()
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = palette.surface0 })
  end,
}
