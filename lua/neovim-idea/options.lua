local Options = {}

-- [[catppuccin]]
local catppuccin_defaults = {
  flavour = "intellijdark",
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
      NeoTreeWinSeparator = { bg = colors.crust, fg = colors.crust },
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
}

Options.catppuccin = {}

-- [[nvim-cmp]]
local nvim_cmp_defaults = function(cmp)
  return {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered({
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }),
      documentation = cmp.config.window.bordered({
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Esc>"] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- For luasnip users.
    }, {
      { name = "buffer" },
    }),
  }
end

function Options.nvim_cmp(cmp)
  return {}
end

-- [[nvim-dap-ui]]
local nvim_dap_ui_defaults = {
  layouts = {
    {
      elements = {
        { id = "watches", size = 0.15 },
        { id = "repl", size = 0.55 },
        { id = "scopes", size = 0.15 },
        { id = "stacks", size = 0.15 },
      },
      position = "bottom",
      size = 12,
    },
  },
  controls = {
    enabled = true,
    element = "stacks",
    icons = {
      play = "",
      pause = "󰏤",
      step_into = "⤵",
      step_over = "⤴",
      step_out = "⤶",
      step_back = "↶",
      run_last = "↻",
      terminate = "",
      disconnect = "⏏",
    },
  },
}

Options.nvim_dap_ui = {}

-- [[edgy.nvim]]
local edgy_nvim_defaults = {
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

Options.edgy_nvim = {}

-- [[gitsigns]]
local gitsigns_defaults = {
  current_line_blame = true,
}

Options.gitsigns = {}

-- [[mason]]
local mason_defaults = {}

Options.mason = {}

-- [[mason-lspconfig]]
local mason_lspconfig_defaults = {
  ensure_installed = { "lua_ls", "ts_ls" },
}

Options.mason_lspconfig = {}

-- [[nvim-metals]]
local nvim_metals_defaults = function(metals, metals_config)
  metals_config.on_attach = function(_, bufnr)
    metals.setup_dap()
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = function()
        pcall(vim.lsp.codelens.refresh)
      end,
    })
    pcall(vim.lsp.codelens.refresh)

    vim.keymap.set("n", "<leader>r", vim.lsp.codelens.run, { buffer = bufnr, desc = "Run code lens" })
  end
  return metals_config
end

function Options.nvim_metals(metals, metals_config)
  return {}
end

-- [[lualine]]
local lualine_defaults = {
  options = {
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
}

Options.lualine = {}

-- [[mini-pairs]]
local mini_pairs_defaults = {}

Options.mini_pairs = {}

-- [[neotree]]
local neotree_defaults = {
  open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline", "trouble", "edgy" },
  popup_border_style = "",
  window = {
    position = "left",
    border = {
      style = "single",
    },
    -- todo: figure out how to set a max width
    --        auto_expand_width = true,
  },
  filesystem = {
    use_libuv_file_watcher = true,
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
  },
  default_component_configs = {
    indent = {
      with_markers = false,
      indent_marker = "",
      last_indent_marker = "",
      highlight = "NeoTreeIndentMarker",
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
  },
}

Options.neotree = {}

-- [[neovim-project]]
local neovim_project_defaults = {
  projects = {
    "~/projects/*",
    "~/.config/*",
  },
  picker = {
    type = "telescope",
  },
}

Options.neovim_project = {}

--[[Accessors]]
function Options.get_catppuccin_options()
  return vim.tbl_deep_extend("force", catppuccin_defaults, Options.catppuccin)
end

function Options.get_nvim_cmp_options(cmp)
  return vim.tbl_deep_extend("force", nvim_cmp_defaults(cmp), Options.nvim_cmp(cmp))
end

function Options.get_nvim_dap_ui_options()
  return vim.tbl_deep_extend("force", nvim_dap_ui_defaults, Options.nvim_dap_ui)
end

function Options.get_edgy_nvim_options()
  return vim.tbl_deep_extend("force", edgy_nvim_defaults, Options.edgy_nvim)
end

function Options.get_gitsigns_options()
  return vim.tbl_deep_extend("force", gitsigns_defaults, Options.gitsigns)
end

function Options.get_mason_options()
  return vim.tbl_deep_extend("force", mason_defaults, Options.mason)
end

function Options.get_mason_lspconfig_options()
  return vim.tbl_deep_extend("force", mason_lspconfig_defaults, Options.mason_lspconfig)
end

function Options.get_nvim_metals_options(metals, m_config)
  return vim.tbl_deep_extend("force", nvim_metals_defaults(metals, m_config), Options.nvim_metals(metals, m_config))
end

function Options.get_lualine_options()
  return vim.tbl_deep_extend("force", lualine_defaults, Options.lualine)
end

function Options.get_mini_pairs_options()
  return vim.tbl_deep_extend("force", mini_pairs_defaults, Options.mini_pairs)
end

function Options.get_neotree_options()
  return vim.tbl_deep_extend("force", neotree_defaults, Options.neotree)
end

function Options.get_neovim_project_options()
  return vim.tbl_deep_extend("force", neovim_project_defaults, Options.neovim_project)
end

return Options
