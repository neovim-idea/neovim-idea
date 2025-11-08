return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<D-f>", builtin.find_files, { desc = "find file" })
      vim.keymap.set("n", "<D-F>", builtin.live_grep, { desc = "fuzzy find in project files (live grep)" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",

          layout_config = {
            vertical = {
              prompt_position = "top",
              mirror = true,
              results_height = 0.45,
              preview_height = 0.55,
            },
            width = 0.5,
            height = 0.55,
          },
        },
        extensions = {
          -- for code actions popup: keep them small!
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              layout_config = {
                width = 0.40,
                height = 0.30,
              },
            }),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
