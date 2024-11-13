# features

## LeaderF

## yazi
- open at file
- open at cwd
- resume

## surround


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

## ft config


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
