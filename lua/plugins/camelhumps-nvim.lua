return {
  "neovim-idea/camelhumps-nvim",
  config = function()
    local camelhump = require("camelhumps").setup()
    vim.keymap.set({ "n", "i", "v" }, "<M-Left>", camelhump.left, { noremap = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<M-Right>", camelhump.right, { noremap = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<M-BS>", camelhump.left_delete, { noremap = true, silent = true })
    vim.keymap.set({ "n", "i", "v" }, "<M-Del>", camelhump.right_delete, { noremap = true, silent = true })
  end,
}
