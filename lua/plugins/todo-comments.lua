return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- TODO add catppuccin palettes #8bb33d
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
