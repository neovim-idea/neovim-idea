return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup(require("neovim-idea.options").get_telescope_nvim_options())
      require("telescope").load_extension("ui-select")

      -- show line numbers in the preview of Telescope
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function(_)
          vim.wo.number = true
        end,
      })
    end,
  },
}
