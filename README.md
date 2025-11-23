# Read This First!

This is a very personal and opinionated customisation of neovim to resemble IntelliJ IDEA look & feel, tailored towards
Scala development (does support Java as well, although I believe it would need extra configuration to support standalone
Java development).

Due to my work laptop being old and with limited amount or RAM, having one instance of IntelliJ IDEA running along with
Chrome and Slack had become... problematic. Add to the mix dockerized instances of kafka/postgres/redis/amqp and so on,
and the system just turns downright unusable.

Because of that, I needed a **quick** replacement for IntelliJ to shave off those ~4GB of memory and keep me working;
obviously, neovim was the IDE of choice.

HOWEVER: despite my (limited) previous knowledge of (neo)vim, I had nor the time or the inclination to learn a whole
plethora of commands and shortcuts to be used in different modes. Call it laziness, old age or muscle memory. As a
direct consequence of it, I brazenly messed with the key shortcuts in a way that any respectable neovim user would either
get angry or weep in despair. Sorry, not sorry, I've got work to do. 

If you, however, think you can stomach that: enjoy the repo! Feel free to clone it and tweak it as you please :)   


## Plugin Options

`neovim-idea` comes "batteries included": it contains all the necessary plugins and configurations to mimic the UI/UX
that you would normally see in IntellIJ. However, should you feel the need to change some configurations options or
keymaps, you are encouraged to do so.


### [catppuccin](https://github.com/catppuccin/nvim)
<details>
<summary>neovim-idea default options</summary>

```lua
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
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the table like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").catppuccin = {
  flavour = "latte",
  auto_integrations = false,
  custom_highlights = function(colors)
    return {} -- resets neovim-idea custom color overrides
  end,
  -- add as many catppuccin's options as you'd like
}
```


### [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
<details>
<summary>nvim-cmp default options</summary>

```lua
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
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the function like so (it can accept
a `cmp` parameter that comes from `require(nvim-cmp)` in case you'd need it)

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").nvim_cmp = function(cmp)
  return {
    -- add as many nvim-cmp's options as you'd like
  }
end
```


### [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
<details>
<summary>nvim-dap-ui default options</summary>

```lua
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
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the table like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").nvim_dap_ui = {
    -- add as many nvim-dap-ui's options as you'd like
}
```


### [edgy.nvim](https://github.com/folke/edgy.nvim)
<details>
<summary>edgy.nvim default options</summary>

```lua
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
  },  bottom = {},
  options = {
    left = { size = 40 },
    bottom = { size = 12 },
  },
}
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the table like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").edgy_nvim = {
    -- add as many edgy_nvim's options as you'd like
}
```


### [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
<details>
<summary>gitsigns default options</summary>

```lua
local gitsigns_defaults = {
  current_line_blame = true,
}
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the table like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").gitsigns = {
    -- add as many gitsigns's options as you'd like
}
```


### [mason](https://github.com/mason-org/mason.nvim)
<details>
<summary>mason default options</summary>

```lua
local mason_defaults = {}
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the table like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").mason = {
    -- add as many mason's options as you'd like
}
```


### [mason-lsp](https://github.com/mason-org/mason-lspconfig.nvim)
<details>
<summary>mason default options</summary>

```lua
local mason_lspconfig_defaults = {
  ensure_installed = { "lua_ls", "ts_ls" },
}
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the table like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").mason_lspconfig = {
    -- add as many mason's options as you'd like
}

```


### [nvim-metals](https://github.com/scalameta/nvim-metals)
<details>
<summary>nvim-metals default options</summary>

```lua
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
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the function like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").nvim_metals = function(metals, metals_config)
    -- add as many metals-config's options as you'd like
  return metals_config
end
```


### [lualine](https://github.com/nvim-lualine/lualine.nvim)
<details>
<summary>lualine default options</summary>

```lua
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
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the table like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").lualine = {
  -- add as many lualine's options as you'd like
}
```


### [mini.pairs](https://github.com/nvim-mini/mini.pairs)
<details>
<summary>mini.pairs default options</summary>

```lua
local mini_pairs_defaults = {}
```
</details>

If you're not happy/satisfied with the options above, feel free to extend/override the table like so

```lua
-- ~/.config/nvim/lua/option-overrides.lua
require("neovim-idea.options").mini_pairs = {
  -- add as many mini.pairs's options as you'd like
}
```




## Shortcuts

> [!IMPORTANT]
> Ensure your terminal doesn't steal CMD key and CMD+number key combinations (i.e. to switch between open terminal tabs:
> use tmux instead!). If you're not sure whether your key combination is recognised by neovim: press `F5`, and neovim
> will print any shortcut to the command line. If nothing gets printed, it means that your terminal or OS is capturing
> it already.


> [!NOTE]
> This setup comes with [which-key](https://github.com/folke/which-key.nvim) preinstalled: either type `:Whichkey` in
> the command prompt, or press `<leader>` (=spacebar in this setup) followed by `?` and a popup will appear, showing all
> available shortcuts that are registered in neovim (navigate Down/Up the popup via CTRL+d/CTRL+u)


In case you're using `Logictech MX Keys` in MacOS, you might have issues trying to figure out why `Fn` keys are still
modifying the brightness/volume/etc.. even though you you specifically toggled on the System Settings option
`use F1, F2 etc. keys as standard function keys`. No, you're not drunk: on my Company's old MBP i9 they worked fine but,
on my personal MBP M1, it didn't; seems like that, on the newer Apple Silicon MBPs, this setting is not honored properly
and therefore you must install [Logi Option+](https://www.logitech.com/en-us/software/logi-options-plus.html), import
your keyboad and then, under the `General` section .. toggle  `use F1, F2 etc. keys as standard function keys`.
Go figure.


| Action | Shortcut | Description | 
| --------------- | --------------- | --------------- |
| Toggle Project Files | CMD+1, CMD+k1 | Toggles the file browser from any window/buffer |
| Show in Project Files | CMD+p | Show current file in the file browser |
| Show Project Files help | ? | Shows all extra actions that can be performed in the file tree, i.e. `a`dd, `r`ename, `d`elete a file or `/` to fuzzy-find files |
| Find files | CMD+f | Find project files by name | 
| Find in files | CMD+F | Fuzzy find some text in the project files | 

## Notes

:warning: Don't know the keymaps?

Just press spacebar and in 500ms (configurable in ./lua/plugins/which-key.lua) it will show an auto completable popup!

remove all existing nvim config files, states etc..

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

1. telescope `live_grep` needs the external program `ripgrep` to work (run `brew install ripgrep`)
2. install `stylua` via `:Mason` to have nice formatting for `*.lua` files
3. install `coursier` to use  `nvim-metals` (run `brew install coursier`)
4. install metals in nvim using the command `:MetalsInstall`
5. install lazygit (run `brew install lazygit`) 
6. install treesitter cli (run `brew install tree-sitter-cli`)
7. open your scala project and have fun

Optionally, if you want to enable Java development:

1. `brew install mvn`
2. from within neovim, type `:Mason` command and look for the `java-language-server`, then hit `i` to install
    (note: [needs at least Java18](https://github.com/georgewfraser/java-language-server/issues/273))
3. follow instructions from [lsp-config official documentation page](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#java_language_server)


## Keyboard remappings

1. right CMD into Super

## Things not supported

Sadly there are things that are not supported

### Directly capturing parts of a line

In IntelliJ, when presented with a line like the following

```scala
val result = somelist.filter(x => filterPredicate(x)).map(v => v % 10)
```

you can choose whether set a breakpoint at line level and/or put extra breakpoints at `x` and `v` position;
this is, saldy, not possible (as far as my knowledge goes) with neovim.

However it is possible to set conditional breakpoints like so

> :DapSetBreakpoint --condition 'x == someValue'


## Things To Improve

* [x] project manager
* [ ] by default, when opening a project: open in order `README.md` or `build.sbt`
* [ ] keep insert mode after autocompletion
* [x] simple camel hump navigation
  * [ ] extract logic in its own plugin
    * [ ] add proper testing
  * [ ] make own plugin to addd functional-style lua for easier development
* [x] autosave buffers
* [ ] make neotree condense package folders
* [ ] shortcuts to create new class/obj
* [x] shortcuts to implement all methods from trait/abstract class
* [x] undo with D-z
* [x] make neotree stick to the left sidebar
  * [x] use https://github.com/folke/edgy.nvim
* [x] make the files open in the main content area
* [x] reshuffle the UI of dap
* [ ] one single place to define all key combinations
* [ ] unified way to define keymap (don't use two different APIs)
* [ ] delete holding SHIFT should "camelHump delete"
* [ ] select holding SHIFT should "camelHump select"
* [x] add shortcut to duplicate current line and place it below
* [x] SHIFT+UP/DOWN moves the current line up/down
* [x] use https://github.com/folke/snacks.nvim/tree/main/docs for lazygit
  * [x] terminal (?)
* [x] find out how to rename variables, classes
  * [ ] ... and [files](https://github.com/folke/snacks.nvim/blob/main/docs/rename.md)
* [x] show errors in the current line
* [x] click on a gutter to toggle a breakpoint creation on/off
* [ ] scratch files management for quick & dirty snippets
* [x] copy paste shortcuts using D-c, D-x, D-v
* [x] toggle comment/uncomment with <D-/>
* [x] use notification plugin to avoid losing focus from the buffer
  * [x] add telescope integration to retrieve notifications in case we need to copy/paste logs
* [ ] bind mouse keys prev/next to cycle between open files
* [ ] global search & replace
* [x] when exiting lazygit, neotree should refresh its status icons
* [ ] highlight a line that has a breakpoint set
* [ ] update treesitter to `main` and figure out where the configuration options are now located
