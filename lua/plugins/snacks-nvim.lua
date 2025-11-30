return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      terminal = { enabled = true },
      lazygit = { enabled = true },
      input = { enabled = true },
    },
    keys = {
      {
        "<D-F12>",
        require("neovim-idea.actions").toggle_terminal,
        mode = { "n", "i", "t" },
        desc = "Toggle Bottom Terminal (Snacks)",
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      local Snacks = require("snacks")
      vim.keymap.set({ "n", "i" }, "<D-G>", function()
        Snacks.lazygit.open()
      end, { desc = "open lazygit" })

      -- fire a neotree event when lazygit closes
      -- many thanks to https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/1253#discussioncomment-9971975
      local events = require("neo-tree.events")
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "term://*lazygit*",
        callback = function()
          events.fire_event(events.GIT_EVENT)
        end,
      })
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    dependencies = { "folke/snacks.nvim" },
    lazy = false,
    config = function()
      require("inc_rename").setup({ input_buffer_type = "snacks" })
    end,
  },
}
