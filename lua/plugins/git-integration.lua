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
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })
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
  {
    "folke/snacks.nvim",
    lazy = true,
    opts = {
      lazygit = {},
    },
    config = function()
      local Snacks = require("snacks")
      vim.keymap.set({ "n", "i" }, "<D-G>", function()
        Snacks.lazygit.open()
      end, { desc = "open lazygit" })
    end,
  },
}
