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
    local neotree = require("neo-tree")
    neotree.setup({
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
      default_component_configs = {
        indent = {
          with_markers = false,
          indent_marker = "",
          last_indent_marker = "",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    })

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
