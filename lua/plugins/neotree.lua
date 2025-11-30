return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  config = function()
    require("neo-tree").setup(require("neovim-idea.options").get_neotree_options())
    local actions = require("neovim-idea.actions")
    vim.keymap.set({ "n", "i" }, "<D-1>", actions.toggle_file_tree, { desc = "toggle Neotree sidebar" })
    vim.keymap.set({ "n", "i" }, "<D-k1>", actions.toggle_file_tree, { desc = "toggle Neotree sidebar" })
    vim.keymap.set({ "n", "i" }, "<D-p>", actions.reveal_in_file_tree, { desc = "point in Neotree the current file" })
  end,
}
