return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup(require("neovim-idea.options").get_todo_comments_options())
  end,
}
