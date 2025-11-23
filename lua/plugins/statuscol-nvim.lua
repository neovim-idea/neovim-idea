return {
  "luukvbaal/statuscol.nvim",
  lazy = false,
  dependencies = {
    "folke/todo-comments.nvim",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup(require("neovim-idea.options").get_statuscol_nvim_options(builtin))
  end,
}
