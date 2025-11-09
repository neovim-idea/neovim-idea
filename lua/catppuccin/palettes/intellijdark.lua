-- TODO: remove once the theme has been finalised !
local base = require("catppuccin.palettes.mocha")

local M = {
  -- blue = "#9ca0b0",
  text = "#bcbec4",
  base = "#27282a",
  mantle = "#222225", -- mathematically halfway through base & crust
  crust = "#1c1c1f",
}

-- 45454a -> bordo per le ricerche

return vim.tbl_deep_extend("force", base, M)
