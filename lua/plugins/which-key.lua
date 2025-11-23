return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = require("neovim-idea.options").get_which_key_options(),
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true})
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
