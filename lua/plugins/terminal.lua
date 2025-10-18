return {
--[[
-- NOTE let's keep it as a way to remember how to load local plugins
  {
    dir = vim.fn.stdpath("config") .. "/lua/custom_plugins",
    name = "terminal",
    config = function()
      local terminal = require("custom_plugins.terminal")
      terminal.setup()
      vim.api.nvim_set_keymap(
        "n",
        "<D-2>",
        ":ToggleTerminal<CR>",
        { desc = "toggle terminal", noremap = true, silent = true }
      )
    end,
  },
--]]
}
