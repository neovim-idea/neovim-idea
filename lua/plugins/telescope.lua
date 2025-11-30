return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("neovim-idea.actions")
      vim.keymap.set("n", "<D-f>", actions.find_files, { desc = "find file" })
      vim.keymap.set("n", "<D-F>", actions.fuzzy_find_in_files, { desc = "fuzzy find in project files (live grep)" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup(require("neovim-idea.options").get_telescope_nvim_options())
      require("telescope").load_extension("ui-select")

      -- show line numbers in the preview of Telescope
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function(args)
          vim.wo.number = true
        end,
      })
    end,
  },
}
