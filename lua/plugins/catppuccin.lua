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
          LineNr = { fg = colors.surface0 },
          CursorLineNr = { fg = colors.overlay0 },
          CursorLine = { bg = colors.mantle },
          ColorColumn = { bg = colors.surface0 },
          FloatBorder = { bg = colors.mantle, fg = colors.text },

          -- [[Neotree]]
          NeoTreeWinSeparator = { bg = colors.crust ,fg = colors.crust },
          NeoTreeVertSplit = { bg = "NONE" },
          NeoTreeRootName = { fg = colors.text },
          NeoTreeFileName = { fg = colors.text },
          NeoTreeFileIcon = { fg = colors.text },
          NeoTreeDirectoryName = { fg = colors.text },
          NeoTreeDirectoryIcon = { fg = colors.text },
          NeoTreeGitUntracked = { fg = colors.red },
          NeoTreeGitModified = { fg = colors.lavender },
          NeoTreeGitStaged = { fg = colors.green },
          NeoTreeGitUntrackedFolder = { fg = colors.red },
          NeoTreeGitModifiedFolder = { fg = colors.lavender },
          NeoTreeGitStagedFolder = { fg = colors.green },
          NeoTreeCursorLine = { bg = "#2e3861" },
          NeoTreeFloatTitle = { bg = colors.mantle, fg = colors.text },

          -- [[Telescope - General]]
          TelescopeNormal = { bg = colors.base, fg = colors.text },
          TelescopeBorder = { bg = colors.base, fg = colors.text },
          TelescopeTitle = { bg = colors.base, fg = colors.text },
          TelescopeSelection = { bg = "#2e3861", fg = colors.subtext1, style = {} },
          TelescopeMatching = { bg = "NONE", fg = "NONE", style = { "bold" } },
          -- [[Telescope - Prompt]]
          TelescopePromptTitle = { bg = colors.base, fg = colors.text },
          -- [[Telescope - Results]]
          TelescopeResultsNormal = { bg = colors.base, fg = colors.subtext0 },
          -- [[Telescope - Preview]]
          TelescopePreviewTitle = { bg = colors.base, fg = colors.text },
          TelescopePreviewNormal = { bg = colors.crust, fg = colors.text },
          TelescopePreviewLine = { bg = colors.base, fg = colors.text },

          -- [[Edgy]]
          EdgyTitle = { bg = "NONE", fg = colors.subtext0 },

          -- [[Treesitter]]
          Include = { fg = colors.peach },
          Constant = { fg = colors.yellow },
          ["@attribute.scala"] = { fg = colors.yellow },
          ["@module"] = { fg = colors.text },
          ["@type.scala"] = { fg = colors.text },
          ["@module.scala"] = { fg = colors.text },
          ["@operator.scala"] = { fg = colors.text },
          ["@keyword.scala"] = { fg = colors.peach },
          ["@keyword.type.scala"] = { fg = colors.peach },
          ["@keyword.import.scala"] = { fg = colors.peach },
          ["@keyword.operator.scala"] = { fg = colors.peach },
          ["@keyword.function.scala"] = { fg = colors.peach },
          ["@keyword.modifier.scala"] = { fg = colors.peach },
          ["@keyword.conditional.scala"] = { fg = colors.peach },
          ["@variable.parameter.scala"] = { fg = colors.mauve, style = { "italic" } },
          ["@function.call.scala"] = { fg = colors.text },
          ["@punctuation.special.scala"] = { fg = colors.peach },
          ["@variable.member.scala"] = { fg = colors.mauve },
          ["@comment.scala"] = { fg = colors.green },
          ["@comment.documentation.scala"] = { fg = colors.green },

          -- [[LSP - Scala]]
          ["@lsp.type.keyword.scala"] = { fg = colors.peach },
          ["@lsp.type.class.scala"] = { fg = colors.text },
          ["@lsp.type.type.scala"] = { fg = colors.text },
          ["@lsp.type.interface.scala"] = { fg = colors.text },
          ["@lsp.type.operator.scala"] = { fg = colors.text },
          ["@lsp.type.method.scala"] = { fg = colors.text },
          ["@lsp.type.variable.scala"] = { fg = colors.text },
          ["@lsp.type.comment.scala"] = { fg = colors.green },
          ["@lsp.type.typeParameter.scala"] = { fg = colors.teal },
          ["@lsp.type.modifier.scala"] = { fg = colors.peach },
          ["@lsp.type.namespace.scala"] = { style = {} },
          -- this kinda works, but there's a limitation in the LSP that local variables and fields/class members share
          -- the same high-priority token, hence vals defined in function are colored in mauve as well :-/
          ["@lsp.typemod.variable.readonly.scala"] = { fg = colors.mauve },
          -- an alternative would be this, but some class/trait val definition are skipped ...
          -- ["@lsp.typemod.variable.declaration.scala"] = { fg = colors.mauve },
          -- ["@lsp.typemod.variable.definition.scala"] = { fg = colors.text },
          -- ["@lsp.typemod.variable.readonly.scala"]   = { fg = colors.text },
          ["@lsp.typemod.type.abstract.scala"] = { fg = colors.teal },
          ["@lsp.typemod.parameter.declaration.scala"] = { fg = colors.text },
          ["@lsp.typemod.parameter.readonly.scala"] = { fg = colors.text },
          ["@lsp.typemod.method.declaration.scala"] = { fg = colors.blue },
          ["@lsp.typemod.method.definition.scala"] = { fg = colors.blue },

          -- [[LSP - Sbt]]
          ["@lsp.type.class.sbt"] = { fg = colors.text },
          ["@lsp.type.method.sbt"] = { fg = colors.text },
          ["@lsp.type.operator.sbt"] = { fg = colors.text },
          ["@lsp.type.keyword.sbt"] = { fg = colors.peach },
          ["@lsp.type.modifier.sbt"] = { fg = colors.peach },
          ["@lsp.type.comment.sbt"] = { fg = colors.overlay0 },
        }
      end,
    })
    vim.cmd.colorscheme("catppuccin-intellijdark")
  end,
}
