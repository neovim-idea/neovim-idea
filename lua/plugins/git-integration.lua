return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", {})
      -- make fugitive buffers easier to quit
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fugitive", "fugitiveblame" },
        callback = function()
          vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true })
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup(require("neovim-idea.options").get_gitsigns_options())
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "show git hunk preview" })
      -- TODO: current_line_blame is handy, perhaps just leave it on all the times (?)
      vim.keymap.set(
        "n",
        "<leader>gt",
        ":Gitsigns toggle_current_line_blame<CR>",
        { desc = "show current line last committer" }
      )
    end,
  },
}
