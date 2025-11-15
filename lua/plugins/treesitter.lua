return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- TODO figure out where the new settings went, when moving to "main"
  branch = "master",
  lazy = false,
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      -- auto_install = true -- to autoinstall languages as they're encountered
      ensure_installed = { "lua", "javascript", "java", "scala" },
      highlight = { enable = true },
      indent = { enable = true },
      fold = { enable = true },
    })
  end,
}
