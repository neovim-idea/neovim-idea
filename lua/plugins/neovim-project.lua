return {
  {
    {
      "nvim-mini/mini.icons",
      version = false,
      config = function()
        require("mini.icons").setup({})
      end,
    },
  },
  {
    "coffebar/neovim-project",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    config = function()
      require("neovim-project").setup(require("neovim-idea.options").get_neovim_project_options())
      local actions = require("neovim-idea.actions")
      vim.keymap.set("n", "<leader>pa", actions.show_all_projects, { desc = "Neovim Project: Discover" })
      vim.keymap.set("n", "<leader>pr", actions.show_recent_projects, { desc = "Neovim Project: History" })
    end,
  },
}
