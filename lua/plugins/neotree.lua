return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  opts = function(_, opts)
    opts = opts or {}
    -- don't open files inside edgy windows
    opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
      or { "terminal", "Trouble", "qf", "Outline", "trouble" }
    table.insert(opts.open_files_do_not_replace_types, "edgy")
    -- ensure it opens on the left by default
    opts.window = opts.window or {}
    opts.window.position = "left"
    return opts
  end,
  config = function()
    require("neo-tree").setup({
      -- todo: figure out how to set a max width
      --      window  = {
      --        auto_expand_width = true,
      --      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          use_libuv_file_watcher = true,
          leave_dirs_open = true,
        },
      },
    })

    vim.keymap.set("n", "<D-1>", ":Neotree toggle<CR>", { desc = "toggle Neotree sidebar" })
    vim.keymap.set({ "n", "i" }, "<D-s>", "<Cmd>w<CR>", { desc = "save current buffer" })
    vim.keymap.set({ "n", "i" }, "<D-p>", ":Neotree reveal<CR>", { desc = "point in Neotree the current file" })
    -- vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", {})
    -- open terminal with a height of 10 lines
    -- vim.keymap.set({'n','i'}, '<D-2>', ':botright 10split | file shell | terminal<CR>', {})
  end,
}
