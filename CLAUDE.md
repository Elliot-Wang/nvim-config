# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration (based on jdhao/nvim-config) supporting macOS, Linux, and Windows. The configuration uses a mix of Lua and VimScript, with an ongoing migration toward Lua.

**Minimum Neovim version:** 0.10.2

## Architecture

### Entry Point and Load Order

`init.lua` orchestrates the configuration load sequence:
1. `lua/load.lua` - Loads user config from `config.lua`
2. `lua/globals.lua` - Platform detection (`vim.g.is_win`, `vim.g.is_mac`, `vim.g.is_linux`)
3. `viml_conf/options.vim` - Vim settings
4. `lua/custom-autocmd.lua` - Autocommands
5. `lua/mappings.lua` - Key bindings
6. `viml_conf/plugins.vim` - Plugin loading
7. `viml_conf/plugin/leaderf.vim` - LeaderF config
8. `viml_conf/custom.vim` - Custom VimScript
9. `lua/colorschemes.lua` - Colorscheme setup

### Plugin Management

**Manager:** lazy.nvim (auto-bootstrapped in `lua/plugin_specs.lua`)

Plugin configurations live in `lua/config/` with one file per plugin:
- `lsp.lua` - LSP configuration
- `nvim-cmp.lua` - Completion engine
- `telescope.lua` - Fuzzy finder
- `treesitter.lua` - Syntax highlighting
- `neotree.lua` - File explorer
- `gitsigns.lua` - Git integration
- etc.

### User Customization

User-specific settings go in `config.lua` (not tracked in git):
```lua
vim.env.python3_host_prog = '/usr/bin/python3'
_G.colorschema = 'onedark'
_G.enable_transparent = false
_G.obsidian_opt_workspace = { { name = "personal", path = "~/Obsidian" } }
```

See `example_config.lua` for template.

## Key Mappings Reference

Leader key is `,`

### Navigation
- `gf` - Fuzzy find files (LeaderF)
- `<Leader>se` - Project-wide grep
- `<C-f>` - Search in current buffer
- `ge` - Buffer switcher
- `go` - Recent files (MRU)

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `[d` / `]d` - Navigate diagnostics
- `<space>rn` - Rename symbol
- `<space>ca` - Code action
- `<space>fm` - Format code
- `<C-q>` - Signature help

### Git (via vim-fugitive)
- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>gpl` / `<leader>gpu` - Git pull/push
- `<leader>gg` - LazyGit
- `[c` / `]c` - Navigate git hunks

### Completion
- `<C-n>` / `<C-p>` - Navigate completion menu
- `<CR>` - Confirm selection
- `<Tab>` / `<S-Tab>` - Snippet expand/jump
- `<C-j>` - Accept Copilot suggestion

## Snippets

Custom snippets in `my_snippets/` directory. UltiSnips format.
- Reload snippets: `:call UltiSnips#RefreshSnippets()` or abbreviation `snip`
- `<Tab>` to expand, `<C-j>`/`<C-k>` to jump forward/backward

## File Organization

```
lua/
├── plugin_specs.lua    # All plugin definitions (~970 lines)
├── config/             # Individual plugin configurations
├── mappings.lua        # Key bindings
├── globals.lua         # Global variables, platform detection
├── utils.lua           # Utility functions
└── custom-autocmd.lua  # Autocommands

viml_conf/              # Legacy VimScript (being migrated)
├── options.vim         # Vim options
├── plugins.vim         # Plugin loading
└── custom.vim          # Custom VimScript

my_snippets/            # Custom UltiSnips snippets
```

## Adding New Plugins

1. Add plugin spec to `lua/plugin_specs.lua`
2. Create config file in `lua/config/<plugin-name>.lua` if needed
3. Reference config in the plugin spec's `config` function

## Platform-Specific Notes

- macOS: Uses `im-select` for input method switching, Homebrew for lazygit auto-install
- Linux: OSCYank for remote yank support
- Windows: Different path handling in various configs
