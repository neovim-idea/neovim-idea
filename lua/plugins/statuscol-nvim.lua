return {
  "luukvbaal/statuscol.nvim",
  lazy = false,
  dependencies = {
    "folke/todo-comments.nvim",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      setopt = true,
      relculright = true,
      segments = {
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },
        {
          sign = {
            namespace = { "diagnostic/signs" },
            text = { "E", "I", "W", "H" },
            maxwidth = 2,
            colwidth = 1,
            auto = true,
          },
          click = "v:lua.ScSa",
        },
        {
          sign = {
            name = {
              "Dap.*",
              "todo%-sign%-.*",
            },
            maxwidth = 2,
            colwidth = 2,
            -- I prefer to keep this column always shown because the icons for DAP and todos/comments gets too much
            -- close to each other otherwise. And actually it balances pretty nicely the space on the left side of the
            -- line numbers so, it's a win-win-win
            -- auto = true,
          },
          click = "v:lua.ScSa",
        },
        {
          text = { builtin.foldfunc, " " },
          click = "v:lua.ScFa",
        },
        {
          sign = {
            name = { "gitsigns.*" },
            text = { "gitsigns.*" },
            namespace = { "gitsigns.*" },
          },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}
