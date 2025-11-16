return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = function()
      local opts = {
        left = {
          {
            title = "Project Files",
            ft = "neo-tree",
            pinned = true,
            filter = function(buf)
              return vim.b[buf].neo_tree_source == "filesystem"
            end,
            open = "Neotree show position=left filesystem",
          },
        },
        bottom = {},
        options = {
          left = { size = 40 },
          bottom = { size = 12 },
        },
      }

      --[[ TODO let's see if I still need this onece i fix the buffer switcher & git view

      table.insert(opts.left, {
        title = "Neo-Tree Git",
        ft = "neo-tree",
        pinned = true,
        collapsed = true,
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "git_status"
        end,
        open = "Neotree show position=left git_status",
      })
      table.insert(opts.left, {
        title = "Neo-Tree Buffers",
        ft = "neo-tree",
        pinned = true,
        collapsed = true,
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "buffers"
        end,
        open = "Neotree show position=left buffers",
      })
      --]]

      -- Snacks terminal panes across positions; we’ll actually use "bottom"
      -- This matches the official LazyVim edgy extra filters for Snacks terminals
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          -- title = "%{b:snacks_terminal.id}: %{b:term_title}",
          title = "Terminal",
          ft = "snacks_terminal",
          size = { height = 0.20 },
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end

      return opts
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      terminal = { enabled = true },
    },
    keys = {
      {
        "<D-F12>",
        function()
          require("snacks").terminal(nil, { position = "bottom" })
        end,
        mode = { "n", "i", "t" },
        desc = "Toggle Bottom Terminal (Snacks)",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},
    config = function(_, opts)
      --[[ TODO: is this machinery still required?

      local dapui = require("dapui")
      -- dapui.setup(opts) -- TODO is all of this still needed ?
      local dap = require("dap")
      local edgy = require("edgy")
      local Snacks = require("snacks")

      -- helpers to detect visibility *right now*
      local function neotree_is_open()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "neo-tree" then
            return true
          end
        end
        return false
      end
      local function snacks_bottom_is_open()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local w = vim.w[win]
          if w.snacks_win and w.snacks_win.position == "bottom" and w.snacks_win.relative == "editor" then
            return true
          end
        end
        return false
      end

      local saved = { left = false, bottom = false }

      -- when debugging starts: remember what was visible, then hide left/bottom
      dap.listeners.after.event_initialized["edgy_hide_sidebars_for_dap"] = function()
        saved.left = neotree_is_open()
        saved.bottom = snacks_bottom_is_open()
        pcall(edgy.close, "left")
        pcall(edgy.close, "bottom")
        dapui.open({reset = true})
      end

      -- when debugging ends/exits: close dapui and restore what you had
      local function restore_sidebars()
        dapui.close()
        if saved.left then
          pcall(edgy.open, "left")
        end
        if saved.bottom then
          -- open the edgy bottom edgebar, and ensure a terminal shows up there
          pcall(edgy.open, "bottom")
          Snacks.terminal({ position = "bottom" })
        end
      end
      -- NOTE: maybe better remove this autohide feature .. when running the app or test, you'd like to have
      --        the dapui still open to inspect logs
      -- dap.listeners.before.event_terminated["edgy_restore_sidebars_after_dap"] = restore_sidebars
      -- dap.listeners.before.event_exited["edgy_restore_sidebars_after_dap"] = restore_sidebars
      --]]
    end,
  },
}
