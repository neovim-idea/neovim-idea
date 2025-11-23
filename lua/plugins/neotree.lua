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

    -- performs a neotree action, preserving the current mode of the original buffer
    --@param action string
    local neotree_action = function(action)
      local original_buf = vim.api.nvim_get_current_buf()
      local modifiable = vim.api.nvim_buf_get_option(original_buf, "modifiable")
      if modifiable then
        vim.cmd("stopinsert")
      end
      vim.schedule(function()
        vim.cmd("Neotree " .. action)
      end)
    end

    local neotree_toggle = function()
      neotree_action("toggle")
    end
    local neotree_reveal = function()
      neotree_action("reveal")
    end

    vim.keymap.set({ "n", "i" }, "<D-1>", neotree_toggle, { desc = "toggle Neotree sidebar" })
    vim.keymap.set({ "n", "i" }, "<D-k1>", neotree_toggle, { desc = "toggle Neotree sidebar" })
    vim.keymap.set({ "n", "i" }, "<D-p>", neotree_reveal, { desc = "point in Neotree the current file" })
  end,
}
