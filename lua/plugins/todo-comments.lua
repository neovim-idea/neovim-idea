return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
      gui_style = {
        bg = "NONE",
      },
      highlight = {
        before = "",
        keyword = "fg",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:*]],
      },
    })
  end,
}
