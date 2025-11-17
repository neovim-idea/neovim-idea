return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        -- theme = "catppuccin-intellijdark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_y = {
          {
            "lsp_status",
            icon = "󱤢",
            symbols = {
              spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              done = "✓",
              separator = " ",
            },
            -- LSPs that we don't care to show
            ignore_lsp = { "null-ls", "stylua" },
            show_name = true,
          },
          "progress",
        },
      },
    })
  end,
}
