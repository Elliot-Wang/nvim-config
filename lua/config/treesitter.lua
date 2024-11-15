require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "lua", "vim", "json", "markdown", "java"},
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'help' }, -- list of language that will be disabled
  },
}
