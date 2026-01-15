<div align="center">
<p>
    <a>
      <img alt="Linux" src="https://img.shields.io/badge/Linux-%23.svg?style=flat-square&logo=linux&color=FCC624&logoColor=black" />
    </a>
    <a>
      <img alt="macOS" src="https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white" />
    </a>
    <a>
      <img alt="Windows" src="https://img.shields.io/badge/Windows-%23.svg?style=flat-square&logo=windows&color=0078D6&logoColor=white" />
    </a>
    <a href="https://github.com/jdhao/nvim-config/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/jdhao/nvim-config" />
    </a>
    <a href="https://github.com/neovim/neovim/releases/tag/stable">
      <img src="https://img.shields.io/badge/Neovim-0.10.2-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=green" alt="Neovim minimum version"/>
    </a>
    <a href="https://github.com/jdhao/nvim-config/search?l=vim-script">
      <img src="https://img.shields.io/github/languages/top/jdhao/nvim-config" alt="Top languages"/>
    </a>
    <a href="https://github.com/jdhao/nvim-config/graphs/commit-activity">
      <img src="https://img.shields.io/github/commit-activity/m/jdhao/nvim-config?style=flat-square" />
    </a>
    <a href="https://github.com/jdhao/nvim-config/releases/tag/v0.10.1">
      <img src="https://img.shields.io/github/commits-since/jdhao/nvim-config/v0.10.1?style=flat-square" />
    </a>
    <a href="https://github.com/jdhao/nvim-config/graphs/contributors">
      <img src="https://img.shields.io/github/contributors/jdhao/nvim-config?style=flat-square" />
    </a>
    <a>
      <img src="https://img.shields.io/github/repo-size/jdhao/nvim-config?style=flat-square" />
    </a>
    <a href="https://github.com/jdhao/nvim-config/blob/master/LICENSE">
      <img src="https://img.shields.io/github/license/jdhao/nvim-config?style=flat-square&logo=GNU&label=License" alt="License"/>
    </a>
</p>
</div>

# Introduction

This repo hosts my Nvim configuration for Linux, macOS, and Windows.
`init.lua` is the config entry point for terminal Nvim,
and `ginit.vim` is the additional config file for [GUI client of Nvim](https://github.com/neovim/neovim/wiki/Related-projects#gui).

My configurations are heavily documented to make it as clear as possible.
While you can clone the whole repository and use it, it is not recommended though.
Good configurations are personal. Everyone should have his or her unique config file.
You are encouraged to copy from this repo the part you want and add it to your own config.

To reduce the possibility of breakage, **this config is only maintained for [the latest nvim stable release](https://github.com/neovim/neovim/releases/tag/stable).
No effort is spent on maintaining backward compatibility.**

# Install and setup

See [doc here](docs/README.md) on how to install Nvim's dependencies, Nvim itself,
and how to set up on different platforms (Linux, macOS, and Windows).

# Features #

+ Plugin management via [Lazy.nvim](https://github.com/folke/lazy.nvim).
+ Code, snippet, word auto-completion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
+ Language server protocol (LSP) support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
+ Git integration via [vim-fugitive](https://github.com/tpope/vim-fugitive), [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) and [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim).
+ Fuzzy finder via [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) and [LeaderF](https://github.com/Yggdroot/LeaderF).
+ Faster code commenting via [vim-commentary](https://github.com/tpope/vim-commentary).
+ Faster matching pair insertion and jump via [nvim-autopairs](https://github.com/windwp/nvim-autopairs).
+ Smarter matching pair management (add, replace or delete) via [vim-surround](https://github.com/tpope/vim-surround).
+ Fast buffer jump via [hop.nvim](https://github.com/smoka7/hop.nvim).
+ Powerful snippet insertion via [Ultisnips](https://github.com/SirVer/ultisnips).
+ Beautiful statusline via [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
+ File tree explorer via [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) and [yazi.nvim](https://github.com/mikavilpas/yazi.nvim).
+ Better quickfix list with [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf).
+ Show search index and count with [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens).
+ Command line auto-completion via [wilder.nvim](https://github.com/gelguy/wilder.nvim).
+ User-defined mapping hint via [which-key.nvim](https://github.com/folke/which-key.nvim).
+ Asynchronous code execution via [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim).
+ Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
+ Beautiful colorscheme via [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material) and other colorschemes.
+ Markdown writing and previewing via [vim-markdown](https://github.com/preservim/vim-markdown) and [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim).
+ Obsidian note-taking support via [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim).
+ Animated GUI style notification via [nvim-notify](https://github.com/rcarriga/nvim-notify).
+ Tags navigation via [vista](https://github.com/liuchengxu/vista.vim).
+ Code formatting via [Neoformat](https://github.com/sbdchd/neoformat).
+ Undo management via [vim-mundo](https://github.com/simnalamburt/vim-mundo).
+ Code folding with [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) and [statuscol.nvim](https://github.com/luukvbaal/statuscol.nvim).
+ Debugger support via [nvim-dap](https://github.com/mfussenegger/nvim-dap).
+ AI coding assistant via [claudecode.nvim](https://github.com/anthropics/claude-code/tree/main/neovim) (macOS only).
+ Multi-feature enhancement via [snacks.nvim](https://github.com/folke/snacks.nvim).

# UI Demo

For more UI demos, check [here](https://github.com/jdhao/nvim-config/issues/15).

## Start screen with dashboard-nvim

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/183256752-fb23b215-a6b8-4646-beed-9999f52d53f1.png" width="800">
</p>

## File fuzzy finding (Telescope / LeaderF)

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/183257017-2d9d7605-3c4b-4e1d-8955-30998f9b6f28.gif" width="800">
</p>

## Code autocompletion with nvim-cmp

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128590006-0fc1451f-fac1-49b2-bb95-8aba21bfa44e.gif" width="800">
</p>

## Git add, commit and push via fugitive.vim

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128590833-aaa05d53-19ef-441d-a5a9-ba1bbd3936c1.gif" width="800">
</p>

## Command-line autocompletion with wilder.nvim

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/147677787-8e5d229a-a16a-420e-98f5-88f2a1be84a2.gif" width="800">
</p>

## Tags

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128589584-4036a1a2-2e0a-4bbe-8aaf-ff8b91644648.jpg" width="800">
</p>

## Cursor jump via hop.nvim

Go to a string starting with `se`

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/139459219-8a7e6ac4-1d24-4008-a370-b56773d7cb85.gif" width="800">
</p>

## GUI-style notification with nvim-notify

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128589873-aadb8264-1098-4834-9876-fa66a309be05.gif" width="800">
</p>

## code folding with nvim-ufo and statuscol.nvim

<p align="center">
<img src="https://github.com/user-attachments/assets/a01a56b2-7c91-43de-b305-f2fbaa81dcec" width="800">
</p>

# Shortcuts

Some of the shortcuts I use frequently are listed here. In the following shortcuts, `<leader>` represents ASCII character `,`.

## Search & Navigation

| Shortcut     | Mode   | Description                              |
|--------------|--------|------------------------------------------|
| `gf`         | Normal | Fuzzy find recent files (Telescope)      |
| `<space>se`  | Normal | Project-wide grep (Telescope live_grep)  |
| `<C-f>`      | Normal | Fuzzy search in current buffer           |
| `ge`         | Normal | Buffer switcher                          |
| `<C-p>`      | Normal | Command palette                          |
| `gd`         | Normal | LSP references                           |
| `to`         | Normal | Hop to character (2 chars)               |
| `tr`         | Normal | Hop to line                              |
| `J`          | Normal | Move down 15 lines                       |
| `K`          | Normal | Move up 15 lines                         |
| `H`          | Normal | Go to start of line                      |
| `L`          | Normal | Go to end of line                        |

## File Explorer & Buffers

| Shortcut     | Mode   | Description                              |
|--------------|--------|------------------------------------------|
| `tt`         | Normal | Toggle Neotree file explorer             |
| `tg`         | Normal | Neotree git status                       |
| `tb`         | Normal | Neotree buffers                          |
| `gy`         | Normal | Toggle yazi file manager                 |
| `<leader>cw` | Normal | Open yazi in working directory           |
| `th`         | Normal | Previous buffer                          |
| `tl`         | Normal | Next buffer                              |
| `tn`         | Normal | New tab                                  |
| `td`         | Normal | Close tab                                |
| `tH` / `tL`  | Normal | Go to left/right tab                     |

## Window Management

| Shortcut           | Mode   | Description                              |
|--------------------|--------|------------------------------------------|
| `sh` / `sl`        | Normal | Switch to left/right split               |
| `sk` / `sj`        | Normal | Switch to up/down split                  |
| `ss`               | Normal | Cycle through splits                     |
| `sH` / `sL`        | Normal | Create left/right split                  |
| `sK` / `sJ`        | Normal | Create up/down split                     |
| `sc`               | Normal | Close current split                      |

## Save & Quit

| Shortcut | Mode   | Description                              |
|----------|--------|------------------------------------------|
| `S`      | Normal | Save current buffer                      |
| `Q`      | Normal | Close current buffer                     |
| `ZS`     | Normal | Save all and quit                        |
| `ZQ`     | Normal | Force quit all                           |

## Git (via vim-fugitive & lazygit)

| Shortcut       | Mode   | Description                              |
|----------------|--------|------------------------------------------|
| `<leader>gs`   | Normal | Git status                               |
| `<leader>ga`   | Normal | Git add current file                     |
| `<leader>gc`   | Normal | Git commit                               |
| `<leader>gl`   | Normal | Git pull                                 |
| `<leader>gp`   | Normal | Git push                                 |
| `<leader>gf`   | Normal | Git fetch                                |
| `<leader>gbl`  | Normal | Git blame                                |
| `<leader>gbn`  | Normal | Create new branch                        |
| `<leader>gbd`  | Normal | Delete branch                            |
| `gl`           | Normal | Open LazyGit                             |

## Editing & Misc

| Shortcut       | Mode          | Description                              |
|----------------|---------------|------------------------------------------|
| `<leader>ec`   | Normal        | Edit nvim config                         |
| `<leader>rc`   | Normal        | Reload nvim config                       |
| `<leader>st`   | Normal        | Show highlight group for cursor text     |
| `<leader>cd`   | Normal        | Change cwd to current buffer's directory |
| `<leader>cl`   | Normal        | Toggle cursor column                     |
| `tm`           | Normal        | Vista show (tags)                        |
| `tu`           | Normal        | Toggle undo tree (Mundo)                 |
| `gx`           | Normal/Visual | Open link under cursor                   |
| `ga`           | Normal/Visual | Easy align                               |
| `Alt-k`        | Normal/Visual | Move line/selection up                   |
| `Alt-j`        | Normal/Visual | Move line/selection down                 |
| `Alt-m`        | Normal        | Markdown preview (macOS)                 |

## Claude Code (AI Assistant)

Integration with [Claude Code](https://github.com/anthropics/claude-code) via [claudecode.nvim](https://github.com/anthropics/claude-code/tree/main/neovim).

| Shortcut     | Mode          | Description                                      |
|--------------|---------------|--------------------------------------------------|
| `<leader>am` | Normal        | Select Claude model                              |
| `<C-]>`      | Normal        | Resume Claude (previous conversation)            |
| `<C-]>`      | Terminal      | Close/unfocus Claude terminal                    |
| `<leader>aa` | Normal        | Add current buffer to Claude context             |
| `<leader>aa` | Visual        | Send selection to Claude                         |
| `<leader>aa` | File Explorer | Add file to Claude context (NvimTree, neo-tree, oil, minifiles, netrw) |
| `<leader>ac` or `:w` | Normal        | Accept diff from Claude                          |
| `<leader>ad` or `:q` | Normal        | Deny diff from Claude                            |

# Custom commands

In addition to commands provided by various plugins, I have also created some custom commands for personal use.

| command      | description                                                             | example                        |
|--------------|-------------------------------------------------------------------------|--------------------------------|
| `Redir`      | capture command output to a tabpage for easier inspection.              | `Redir hi`                     |
| `Edit`       | edit multiple files at the same time, supports globing                  | `Edit *.vim`                   |
| `Datetime`   | print current date and time or convert Unix time stamp to date and time | `Datetime 12345` or `Datetime` |
| `JSONFormat` | format a JSON file                                                      | `JSONFormat`                   |

# Contributing

If you find anything that needs improving, do not hesitate to point it out or create a PR.

If you come across an issue, you can first use `:checkhealth` command provided by `nvim` to trouble-shoot yourself.
Please read carefully the messages provided by health check.

If you still have an issue, [open a new issue](https://github.com/jdhao/nvim-config/issues).

# Further readings

Some of the resources that I find helpful in mastering Nvim is documented [here](docs/nvim_resources.md).
You may also be interested in my posts on configuring Nvim:

+ My nvim notes can be found [here](https://jdhao.github.io/categories/Nvim/)
+ [Using Neovim for Three years](https://jdhao.github.io/2021/12/31/using_nvim_after_three_years/)
+ [Config nvim on Linux for Python development](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)
+ [Nvim config on Windows 10](https://jdhao.github.io/2018/11/15/neovim_configuration_windows/)
+ [Nvim-qt config on Windows 10](https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/)
