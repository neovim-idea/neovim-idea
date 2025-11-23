return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = function()
      local opts = require("neovim-idea.options").get_edgy_nvim_options()

      -- Snacks terminal panes across positions; we’ll actually use "bottom"
      -- This matches the official LazyVim edgy extra filters for Snacks terminals
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          -- title = "%{b:snacks_terminal.id}: %{b:term_title}",
          title = "Terminal",
          ft = "snacks_terminal",
          size = { height = 0.20 },
          filter = function(_, win)
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
}
