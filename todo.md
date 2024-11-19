# todo list
- [x] fuzzy finder and preview
    - LeaderF first, telescope, fzf.lua as alternatives.
- [x] remove useless plugin
    - vlime/vlime, for LISP
    - nvim-zh/better-escape.vim
    - Neur1n/neuims - input method switcher, long time(4y) not updated.
    - chrisbra/unicode.vim
    - glacambre/firenvim - condition barely meet, even it is fun
    - copilot - I dont have money!
- [x] remove useless feature
- [x] introduce my config
    - from `.vimrc`, safe and sound!
- [x] colorschema, because of lazy load. colorschema implement not work for not loaded colorschema.
- [x] fix bugs
    - liuchengxu/vista.vim - tags error
    - wilder waring. `:UpdateRemotePlugins` may be useful [Unknown function: _wilder_python_search · Issue #203 · gelguy/wilder.nvim](https://github.com/gelguy/wilder.nvim/issues/203)
    - [ ] leaderF jump by `rg` is not correct.
    - [ ] python lsp is not perfect
      [用 vim/nvim 写 Python 用什么插件？ - V2EX](https://www.v2ex.com/t/998262)
      [vim/nvim 中是否有能匹敌 pylance 的 Python LSP - V2EX](https://www.v2ex.com/t/916463)

## practice neovim
- gc -> leader+C, **leave it alone**
- lsp config [nvim-cmp](https://github.com/iguanacucumber/magazine.nvim)
  - inline hint, enable it!
    *pyright* not support it, *coc-pyright* is the only option.
  - show document, Why it not work when *cursor hold*.
    *coc-pyright* is better!
  - [ ] research **fidget**: *Fidget is an unintrusive window in the corner of your editor that manages its own lifetime.*
- code action `<leader>+ca` - kosayoda/nvim-lightbulb
  - code action list ***providers*** is various!
- hop.nvim like sneaker, *comment it*, config later [Commands · smoka7/hop.nvim Wiki](https://github.com/smoka7/hop.nvim/wiki/Commands)
- organize snippets
  - [ ] ultisnips **problem**
    - trigger key, simple text or regexp
    - expand condition, trigger key or auto trigger
    - conflict with vim-cmp, if vim-cmp missing ultisnips, **it will go wrong**!
- update nvim config at once
  - `<leader>+rc` reload
- surround, still use `surround.vim`
- IDE compiler and run
  - `F9` compile it and run
  - [ ] debuger?
- [ ] obsidian repo
  - coc-marksman, with *coc lsp*, it could preview doc(`[[doc-name]]`)
- [ ] tags (like this `#vim`) search for markdown files
- [?] move *qf* windows to new window or even float window.
  - if only I want to read it and keep it for a while,
    otherwise I will close it immediately.
- [x] input method switcher

## beatufier
- colorful indent line "lukas-reineke/indent-blankline.nvim"
- IMPROVE IT: highlight line is hard to recognized
  - **yazi**, highlight color is to closed to background
- research it [akinsho/bufferline.nvim: A snazzy bufferline for Neovim](https://github.com/akinsho/bufferline.nvim)
  - enable tabpages
  - enable sidebar seperate
  - enable picking tab use a char
  - hover event
  - custom area, pin tab, groups, lsp indicator, etc.
- minimap [wfxr/minimap.vim: 📡 Blazing fast minimap / scrollbar for vim, powered by code-minimap written in Rust.](https://github.com/wfxr/minimap.vim?tab=readme-ov-file)
- [x] vista colorschema
  - rainbow for every level; use `Toch` at markdown instead.

