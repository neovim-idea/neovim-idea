return {
  {
    "tpope/vim-fugitive",
    config = function()
      -- make fugitive buffers easier to quit
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fugitive", "fugitiveblame" },
        callback = function()
          vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true })
          vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = true })
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup(require("neovim-idea.options").get_gitsigns_options())
      local gitsigns_actions = require("gitsigns.actions")
      require("neovim-idea.actions").setup({ gitsigns_actions = gitsigns_actions })
    end,
  },
}
