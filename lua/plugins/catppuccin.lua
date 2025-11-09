return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local path = vim.fn.expand("~/.config/nvim/lua/catppuccin/palettes/")
    local files = vim.fn.globpath(path, "*", false, true)
    local flavours = { latte = 1, frappe = 2, macchiato = 3, mocha = 4 }

    for i, file in ipairs(files) do
      local name = vim.fn.fnamemodify(file, ":t:r")
      flavours[name] = 4 + i
    end

    local catppuccin = require("catppuccin")
    catppuccin.flavours = flavours
    catppuccin.setup({
      auto_integrations = true,
      custom_highlights = function(colors)
        -- intellij-specific tweaks
        return {
          -- [[Generic]]
          Normal = { bg = colors.crust, fg = colors.text },
          NormalNC = { bg = colors.crust, fg = colors.text },
          -- TODO why these won't work even after manually cancelling all caches ??? ffs...
          -- LineNr = { fg = colors.surface2 },
          -- NormalCursorLineNr = { fg = colors.surface0 },
          -- NormalCursorLine = { fg = colors.surface0 },

          FloatBorder = { bg = colors.base, fg = colors.text },

          -- [[Neotree]]
          NeoTreeGitUntracked = { fg = colors.red },
          NeoTreeGitModified = { fg = colors.blue },
          NeoTreeGitStaged = { fg = colors.green },
          NeoTreeGitUntrackedFolder = { fg = colors.red },
          NeoTreeGitModifiedFolder = { fg = colors.blue },
          NeoTreeGitStagedFolder = { fg = colors.green },
          NeoTreeCursorLine = { bg = "#2e3861" },

          -- [[Telescope]]
          TelescopeNormal = { bg = colors.base, fg = colors.text },
          TelescopeBorder = { bg = colors.mantle, fg = colors.text },
          TelescopePreviewTitle = { bg = colors.crust, fg = colors.text },
          TelescopePreviewNormal = { bg = colors.crust, fg = colors.text },
          TelescopePreviewBorder = { bg = colors.crust, fg = colors.text },
        }
      end,
    })
    vim.cmd.colorscheme("catppuccin-intellijdark")
  end,
}
