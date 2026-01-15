# features

- input method switch: 'im-select'

## fuzzy searcher

Primary: **Telescope**, LeaderF partially used.

| mapping | effect | action |
| --- | --- | --- |
| gf | find file (frecency) | `Telescope frecency` |
| <space>se | search through files | `builtin.live_grep` |
| <C-f> | search at current buffer | `builtin.current_buffer_fuzzy_find` |
| gm | buffer tags | `:<C-U>Leaderf bufTag --popup<CR>` (LeaderF) |
| ge | find buffer | `builtin.buffers` |
| gd | LSP references | `builtin.lsp_references` |
| <C-p> | show commands | `builtin.commands` |

### telescope
- extensions: frecency, project, heading, browser-bookmarks
- used by: obsidian.nvim, commander.nvim

## file browser - yazi
- `gy` open at file
- open at cwd
- resume

## string manipulate

### surround

1. Normal mode
  - change
    - `cs"'`
  - delete
    - `ds"`
  - add
    - `ysiw"`
    - `yss[`
2. Visual mode, select and press `S`.
3. surround type
- char `"'[{$(*` etc
- alias `bBra->({[<`
- tag `<a>` `t`
- custom `let g:surround_{char2nr("x")} = "x"`, but it seems don't work


## sidebar
- neo-tree (primary explorer)
  - `tt` toggle neo-tree
  - `tg` git status view
  - `tb` buffer view
- vista (conditional on ctags)
  - `tm` show tags
- undo history: vim-mundo
  - `tu` toggle undo tree
- quickfix: nvim-bqf
- minimap (conditional on code-minimap)

## status line
- a: mode
- b: branch, virtual_env
- c: filename(readonly symbol), diff, ime_status, spell
- x: lsp client, diagnostics
- y: encoding, file_type, file_type
- z: trailing_space, mixed_indent, progress

## snippets

### ultisnips
> The options is a word of characters, each turning a specific option for this
> snippet on. The options currently supported are >
>    !   Overwrite - This snippet will overwrite all previously defined
>        snippets with this tab trigger. Default is to let the user choose at
>        expansion which snippet to expand. This option is useful to overwrite
>        bundled tab stops with user defined ones.
>    b   Beginning of line - This snippet will only be expanded if you are at
>        the beginning of a line (that is if there are only whitespaces in front
>        of the cursor). Default is to expand snippets at every position, even
>        in the middle of a line. Most of my snippets have this option set, it
>        keeps UltiSnips out of the way.
>    i   Inword expansion - Normally, triggers need whitespace before them to be
>        expanded. With this option, triggers are also expanded in the middle of
>        a word.
>    w   Word boundary - Normally, triggers need whitespace before them to be
>        expanded. With this option, the trigger will be expanded at a "word"
>        boundary as well, where word characters are letters, digits, and the
>        underscore character ('_').  This enables expansion of a trigger that
>        adjoins punctuation (for example) without expanding suffixes of larger
>        words.
>    r   Regular expression - This uses a python regular expression for the
>        match. The regular expression MUST be surrounded like a multi-word
>        trigger (see above) even if it doesn't have any spaces. The resulting
>        match is also passed to any python code blocks in your snippet
>        definition as the local variable "match".
>    t   Don't expand tabs - By default, UltiSnips tries to expand leading tabs
>        in a snippet to match the results of automatic indentation. If this
>        option is set, UltiSnips will not try to do this expansion, and will
>        leave the tabs alone. This can be useful for snippets dealing with
>        tab delimited formats, etc.

- reload date snippets `call UltiSnips#RefreshSnippets()`, or abbre `snip`
- `g:UltiSnipsExpandTrigger` <Tab>
- `g:UltiSnipsListSnippets` <C-tab>
- `g:UltiSnipsJumpForwardTrigger` <C-j>
- `g:UltiSnipsJumpBackwardTrigger` <C-k>

## colorscheme

Available (lazy loaded):
- onedark.nvim (dark, darker, cool, deep, warm, warmer, light)
- edge
- sonokai
- gruvbox-material
- everforest
- nightfox.nvim
- catppuccin (latte, frappe, macchiato, mocha)
- onedarkpro.nvim
- material.nvim
- arctic.nvim
- kanagawa.nvim
- dracula

## git

### external tool - lazygit
- `gl` open LazyGit
- auto-installs via Homebrew on macOS


### git plugin group

plugins
- fugitive, git common cmd
    - `<leader>gs` git show status
    - `<leader>ga` git add file
    - `<leader>gc` git commit
    - `<leader>gl` git pull
    - `<leader>gp` git push
    - `<leader>gf` git fetch
    - `<leader>gbl` git blame
    - `<leader>gbn` git create new branch
    - `<leader>gbd` git delete branch
    - `:Git` fugitive-summary
- vim-flog, display log
    - `:Flog`
- git-conflict, for resolving conflict
- gitlinker, browser repo
    - `<leader>gk` Git permlink for commited line
    - `<leader>grp` Git open repo link in browser
- gitsigns, show sign on side column, navigate between hunk
    - `[c`, `]c` navigate between hunks
    - `<leader>hp` preview hunk
    - `<leader>hb` blame line
- diffview, powerful diff tools

## ft config

### markdown
indent = 2

## text object
[你應該擴充的 text object](https://amikai.github.io/2020/09/22/vim-text-object/)
> wellle/targets.vim 和 kana/vim-textobj-user 在開發上使用截然不同的方式，
> 前者定義好大量細膩的 text object，後者則是一個 lib，由使用者以此 lib 為基礎在開發 plugin。

- native
- plugin
  - [kana/vim-textobj-user: Vim plugin: Create your own text objects](https://github.com/kana/vim-textobj-user)
  - michaeljsmith/vim-indent-object
- custom
  - I want a text closed by *space*, write myself

## completion

sources: nvim_lsp, ultisnips, path, buffer

### completion hotkeys
- `<C-n>/<C-p>` select next and previous
- `<CR>` confirm
- `<C-d>/<C-f>` scroll doc
- `<C-e>` abort
- snippet
  - `<Tab>` trigger or jump forwards
  - `<S-Tab>` jump backwards
- copilot
  - `<C-j>` accept suggestion
  - `<M-]>/<M-[>` cycle suggestions
  - `<M-Right>` accept next word
  - `<M-C-Right>` accept next line

## LSP

### lsp hotkeys
- navigate
  - `gd`: go to references (via telescope)
  - `[d`, `]d`: navigate diagnostic
- code
  - `<space>rn`: rename variable
  - `<space>ca`: code action
  - `<space>fm`: code format
- workspace
  - `<space>wl`: list workspace folders
  - `<space>wa`: add workspace folder
  - `<space>wd`: delete workspace folder
- quickfix
  - `<space>qf`: put diagnostics from current files to quickfix
- `<C-q>` show signature help

### lsp languages
Configured (conditional on executable):
- lua (lua_ls)
- vim (vimls)
- python (pyright + ruff)
- bash (bashls)
- go (gopls)
- C/C++ (clangd)
- xml (lemminx)
- latex/markdown (ltex)
- java (nvim-java)

## buffers and tabs

learn buffers `:ls[!] [flags]`
flags/indicator
- `u` an unlisted buffer (only displayed when \[!] is used)
  |unlisted-buffer|
- `%` the buffer in the current window
- `#` the alternate buffer for ":e #" and CTRL-^
- `a` an active buffer: it is loaded and visible
- `h` a hidden buffer: It is loaded, but currently not
  displayed in a window |hidden-buffer|
- `-` a buffer with 'modifiable' off
- `=` a readonly buffer
- `R` a terminal buffer with a running job
- `F` a terminal buffer with a finished job
- `?`    a terminal buffer without a job: `:terminal NONE`
- `+` a modified buffer
- `x`   a buffer with read errors

## mappings

- `q` to `:close` sidebar
- move window between tabs
