return {
  {
    {
      "nvim-mini/mini.icons",
      version = false,
      config = function()
        require("mini.icons").setup(require("neovim-idea.options").get_mini_icons_options())
      end,
    },
  },
  {
    "coffebar/neovim-project",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "Shatur/neovim-session-manager",
    },
    lazy = false,
    priority = 100,
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    config = function()
      require("neovim-project").setup(require("neovim-idea.options").get_neovim_project_options())
    end,
  },
}
