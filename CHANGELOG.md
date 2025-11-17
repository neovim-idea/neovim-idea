## [1.2.1](https://github.com/neovim-idea/neovim-idea/compare/v1.2.0...v1.2.1) (2025-11-17)

### 🩹 Fixes

* added instructions to setup Java LSP ([1f1e7dc](https://github.com/neovim-idea/neovim-idea/commit/1f1e7dcaf2cd4863c43536593efb1310778d9c7c))
* automatically close "show definitions" panel when user hits Enter on one entry ([0449330](https://github.com/neovim-idea/neovim-idea/commit/0449330b6d215f845e0b7344bae6840c003c90f5))
* avoid scrolling too much down ([54f17cf](https://github.com/neovim-idea/neovim-idea/commit/54f17cf517bc50be57e8fa1e6eb3a92a9937b219))
* better blending of neotree win separator ([62bc389](https://github.com/neovim-idea/neovim-idea/commit/62bc38987e1b60ab3cf268590386b7cf6aeaa787))
* better styling to neotree popups ([b652c75](https://github.com/neovim-idea/neovim-idea/commit/b652c75a7af549e7dc13a04a754cad2e6ee08b11))
* better Telescope and Neotree styles ([d7ebd6e](https://github.com/neovim-idea/neovim-idea/commit/d7ebd6ec8b48439b49d38739f59316d82d186974))
* custom colorscheme for Sbt ([87a4f03](https://github.com/neovim-idea/neovim-idea/commit/87a4f033b58b5f90c5270f92a8db2935007cb78b))
* imports should not be italic ([ea80bbd](https://github.com/neovim-idea/neovim-idea/commit/ea80bbd8b9d7b61a856eda4e637e93d66a68fb93))
* keep catppuccin color scheme change and lualine in sync ([eb8b6b1](https://github.com/neovim-idea/neovim-idea/commit/eb8b6b1d6c5916f28a6755d6c0ff2f7fbb5bca25))
* maintain the window separator style when switching between color schemes ([fb83ebd](https://github.com/neovim-idea/neovim-idea/commit/fb83ebd5d6548969d340b523ba8113a1fa53e712))
* minor sbt colorscheme improvement & fmt ([ebbe415](https://github.com/neovim-idea/neovim-idea/commit/ebbe4155a9548af3f256c92f8667dc3e4907dbfa))

## [1.2.0](https://github.com/neovim-idea/neovim-idea/compare/v1.1.0...v1.2.0) (2025-11-15)

### ✨ Features

* added intellij dark colorscheme for LSP ([28f0a6d](https://github.com/neovim-idea/neovim-idea/commit/28f0a6d9d3e189380c41b52b1ca9addea68825e2))
* added intellij dark colorscheme for treesitter ([032e3de](https://github.com/neovim-idea/neovim-idea/commit/032e3dee7f09b1b00a3e0b6bfb16cc8632e7fdaa))
* intellij idea dark & matrix color schemes for catppuccin! ([df5a414](https://github.com/neovim-idea/neovim-idea/commit/df5a414c10d9d5c544b3a67d73702a5b71f2a95c))

### 🩹 Fixes

* automatically discover & add new flavours to catppuccin ([d98fa3c](https://github.com/neovim-idea/neovim-idea/commit/d98fa3ce723b7404adb9c8ac5d4e9a3b841ce26a))
* better virtcolumn and coloring ([7a17643](https://github.com/neovim-idea/neovim-idea/commit/7a176439dff7a93a235ef6a396dce183de2847e3))
* ffs im an idiot ([224573b](https://github.com/neovim-idea/neovim-idea/commit/224573b2a4e96dab845da93e1ff1f9ff62fd29ac))
* last child in a directory has same indentation of all other siblings ([446c2b1](https://github.com/neovim-idea/neovim-idea/commit/446c2b142b2ff4ec49df9f21cf21dc507448c26c))
* make Telscope more IntelliJ-ish ([6c3b210](https://github.com/neovim-idea/neovim-idea/commit/6c3b210564cd78777a1a3801d2e28f03913eb584))
* minor fixes ([49cf208](https://github.com/neovim-idea/neovim-idea/commit/49cf208822acfb4f6a4eac92fb1eb49a84fda38b))
* more reconisable expander icons ([e88819c](https://github.com/neovim-idea/neovim-idea/commit/e88819c111fe5d07b46b8ab758b82b567a9e9f4a))
* override colors for conditionals ([21b8f75](https://github.com/neovim-idea/neovim-idea/commit/21b8f7569c4a34ca792a42334678443851c0d32e))
* show line numnbers in Telescope preview ([7a85b48](https://github.com/neovim-idea/neovim-idea/commit/7a85b4866e8ed6d105c1454538e4e1d7cd2b4ad3))
* switch back treesitter to `master` branch and added a README entry ([08fda28](https://github.com/neovim-idea/neovim-idea/commit/08fda28e7fd46633d0f8b20d26e491527317590a))

## [1.1.0](https://github.com/neovim-idea/neovim-idea/compare/v1.0.1...v1.1.0) (2025-11-14)

### ✨ Features

* proper, intellij-like, line number with gutter icons and mouse actions ([babe026](https://github.com/neovim-idea/neovim-idea/commit/babe026e7e1443a6a4997c2f80bf48c844a7680f))

### 🩹 Fixes

* add autocmd to trigger neotree refresh when lazygit closes ([b831ae0](https://github.com/neovim-idea/neovim-idea/commit/b831ae08caf9eafcc4c512c05fd9ca882fbde78c))
* added Option+Enter to trigger code actions & cleaned up README ([a59ac58](https://github.com/neovim-idea/neovim-idea/commit/a59ac58d0046af77afa98789f16cbfed4711d779))
* disable statuscol for neotree, terminal and help ([c6b9342](https://github.com/neovim-idea/neovim-idea/commit/c6b9342afa2a94f16ef56263b9c686e84fdb1ca7))
* move `use_libuv_file_watcher` to the correct section ([0c7b454](https://github.com/neovim-idea/neovim-idea/commit/0c7b454c1c06610baeec0364652def19deb9c8c4))
* switched to indent-blankline ([087a6cc](https://github.com/neovim-idea/neovim-idea/commit/087a6cc193eb1d83a8a7f3cc615f016ee188345a))

## [1.0.1](https://github.com/neovim-idea/neovim-idea/compare/v1.0.0...v1.0.1) (2025-11-08)

### 📖 Docs

* add small task ([52efa9d](https://github.com/neovim-idea/neovim-idea/commit/52efa9debb8060026316bf562cf6cfab31c67cac))
* added remark regarding MX Keys behaviour on Intel vs Apple Silicon MBPs ([45cc6db](https://github.com/neovim-idea/neovim-idea/commit/45cc6db6dea056185902cf643d12053fe7255b68))
* more detailed infos on whichkey ([25fa8e0](https://github.com/neovim-idea/neovim-idea/commit/25fa8e056008e69fded0958e5fa450b97d5c2381))

### 🩹 Fixes

* (almost) proper right camel hump ([a075bb5](https://github.com/neovim-idea/neovim-idea/commit/a075bb5390839661060c8c24bb1a66ee553db8e9))
* added shortcut to rename symbols ([409c5a1](https://github.com/neovim-idea/neovim-idea/commit/409c5a1bea80d0c0341c527b41cb1a97ec57c866))
* allow renaming in insert mode as well ([6eaddce](https://github.com/neovim-idea/neovim-idea/commit/6eaddcebb88b516bbfbcf3ce4d033d03f771956d))
* better completion/documentation popups & added find/fuzzy find shortcuts to README ([9fa88f9](https://github.com/neovim-idea/neovim-idea/commit/9fa88f9957fe8af4ec1226f801bfcbb9bd2be384))
* cleaned up neotree setup and updated README ([fd28bbf](https://github.com/neovim-idea/neovim-idea/commit/fd28bbf0144c854b09448a7f711327fa7d21acbb))
* closing the popup doesn't change the mode we're in ([01459b4](https://github.com/neovim-idea/neovim-idea/commit/01459b4d03350fb61ce2047b479348cb6db3a5ee))
* disabled buffer-picker and updated README ([8ccf871](https://github.com/neovim-idea/neovim-idea/commit/8ccf871f576822c7ef8321699eedd29fdcb0d77f))
* formatting & removed some comments ([c13c128](https://github.com/neovim-idea/neovim-idea/commit/c13c128e6d8156831ac9ff0989a84fb1cfd94e5f))
* proper left camel hump ([4986b73](https://github.com/neovim-idea/neovim-idea/commit/4986b73a357cfa92dd7e4347b7e4c51e2ea8cb6a))
* removed debugging utilities ([a5115ae](https://github.com/neovim-idea/neovim-idea/commit/a5115ae3f8e0a16d1fe34cde8e9b652a9e7a5389))
* rudimentary implementation of Option from Scala ([044d1a7](https://github.com/neovim-idea/neovim-idea/commit/044d1a7fc034afa531fc86454a19f50ac1a1aadf))
* show all key mappings in whichkey ([84184d0](https://github.com/neovim-idea/neovim-idea/commit/84184d02c4d44a79af2b689643c42c5d771b2cd0))
* show floating, interactive popup to rename symbols ([5515b8d](https://github.com/neovim-idea/neovim-idea/commit/5515b8de2bb4dab35cb657b4a95ba1cac3afb3cc))
* started extraction of left camel humps logic ([4f8c097](https://github.com/neovim-idea/neovim-idea/commit/4f8c097ffd6ecf94034e4331c588e9d6cecf8a5a))

## [1.0.0](https://github.com/neovim-idea/neovim-idea/compare/...v1.0.0) (2025-11-08)

### 🩹 Fixes

* added GitHub Actions for semantic-release and autoassign PRs ([#1](https://github.com/neovim-idea/neovim-idea/issues/1)) ([9819a1f](https://github.com/neovim-idea/neovim-idea/commit/9819a1f8ad39e7cf02a348c4677ff2a5847d23e0))
