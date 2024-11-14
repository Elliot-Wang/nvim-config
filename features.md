# features

## LeaderF

## yazi
- `gy` open at file
- open at cwd
- resume

## surround
Visual mode, select and press `S`.

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

- reload date snippets `call UltiSnips#RefreshSnippets()`
- `g:UltiSnipsExpandTrigger` <C-j>
- `g:UltiSnipsListSnippets` <C-tab>
- `g:UltiSnipsJumpForwardTrigger` <C-j>
- `g:UltiSnipsJumpBackwardTrigger` <C-k>

## colorscheme

colorschema, because of lazy load. colorschema implement not work for not loaded colorschema.

- "navarasu/onedark.nvim"
    ```vim
    " Vim
let g:onedark_config = {
    \ 'style': 'darker',
\}
" Options: dark, darker, cool, deep, warm, warmer, light
colorscheme onedark
    ```
- "sainnhe/edge"
- "sainnhe/sonokai"
- "sainnhe/gruvbox-material"
- "sainnhe/everforest"
- "EdenEast/nightfox.nvim"
- "catppuccin/nvim"
  > colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
- "olimorris/onedarkpro.nvim"
- "marko-cerovac/material.nvim"
- "rockyzhang24/arctic.nvim"
- "rebelot/kanagawa.nvim"
- "dracula/vim"

## git

### external tool - lazygit
`<C-c>` to quit it

```lua
{
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
}
```


### git plugin group

plugins
- fugitive, git common cmd
    - `leader+gs` git show status
    - `leader+ga` git add file
    - `leader+gc` git commit
    - `leader+gl` git pull
    - `leader+gp` git push
    - `leader+gbl` git blame
    - `leader+gbn` git checkout or craete new branch
    - `leader+gbd` git delete branch
    - `:Git` fugitive-summary, there are a bunch of keys.
- vim-flog, display log, one feature, it's optional
    - `:Flog`
- git-conflict, for resolving conflict, effective at some condition
- git-linker, browser repo
    - `leader+gk` Git permlink for commited line.
    - `leader+grp` Git open repo link in browser
- gitsigns, show sign on side column. navigate between hunk
    - `[c`, `]c` navigate between hunks
    - `leader+hp` preview hunk, use `[c`, `]c` to switch between hunks
    - `leader+hb` blame line, dont known how to scroll, and only last commit?
- diffview, powerful diff tools
- todo
    - discard staged

```lua
-- Git command inside vim
{
    "tpope/vim-fugitive",
    event = "User InGitRepo",
    config = function()
        require("config.fugitive")
    end,
},
-- Better git log display
{ "rbong/vim-flog", cmd = { "Flog" } },
{ "akinsho/git-conflict.nvim", version = "*", config = true },
{
    "ruifm/gitlinker.nvim",
    event = "User InGitRepo",
    config = function()
        require("config.git-linker")
    end,
},
-- Show git change (change, delete, add) signs in vim sign column
{
    "lewis6991/gitsigns.nvim",
    config = function()
        require("config.gitsigns")
    end,
},
{
    "sindrets/diffview.nvim",
},
```

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

## LSP
```lua
-- auto-completion engine
{
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    -- event = 'InsertEnter',
    event = "VeryLazy",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-omni",
        "quangnguyen30192/cmp-nvim-ultisnips",
    },
    config = function()
        require("config.nvim-cmp")
    end,
},
{
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
        require("config.lsp")
    end,
},

-- Extensible UI for Neovim notifications and LSP progress messages.
{
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    tag = "legacy",
    config = function()
        require("config.fidget-nvim")
    end,
},
```
### lsp hotkeys
- navigate
  - `gd`: go to definition
  - `gr`: go to references
  - `[d`, `]d`: navigate diagnostic
- code
  - `<space>+rn`: rename variable
  - `<space>+ca`: code action
  - `<space>+fm`: code format
- workspace
  - `<space>+wl`: list workspace folders
  - `<space>+wa`: add workspace folder
  - `<space>+wd`: delete workspace folder
- quickfix
  - `<space>+qw`: put diagnostics from opened files to quickfix
  - `<space>+qb`: put diagnostics from current files to quickfix
- show document?

