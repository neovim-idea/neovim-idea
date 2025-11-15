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
plethora of commands and shortcuts to be used in different modes. Call it lazyness, old age or muscle memory. As a
direct consequence of it, I brazenly messed with the key shortcuts in a way that any respectabe neovim user would either
get angry or weep in despair. Sorry, not sorry, I've got work to do. 

If you, however, think you can stomach that: enjoy the repo! Feel free to clone it and tweak it as you please :)   

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
on my personal MBP M1, it didn't; seems like that, on the newer Apple Silicon MBPs, this setting is not honoerd properly
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

* [ ] project manager
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
