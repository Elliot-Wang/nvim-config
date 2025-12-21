vim.loader.enable()

local utils = require("utils")

local expected_version = "0.10.2"
utils.is_compatible_version(expected_version)

local config_dir = vim.fn.stdpath("config")
---@cast config_dir string

-- load config
require("load")
-- some global settings
require("globals")

-- VSCode-Neovim specific configuration
if vim.g.vscode then
  require("vscode-config")
  -- Load shared mappings for VSCode
  require("mappings")
  -- Load only essential plugins for VSCode
  vim.cmd("source ".. vim.fs.joinpath(config_dir, "viml_conf/plugins.vim"))
  return
end

-- Below configurations are for standalone Neovim only

-- setting options in nvim
vim.cmd("source " .. vim.fs.joinpath(config_dir, "viml_conf/options.vim"))
-- various autocommands
require("custom-autocmd")
-- all the user-defined mappings
require("mappings")
-- all the plugins installed and their configurations
vim.cmd("source ".. vim.fs.joinpath(config_dir, "viml_conf/plugins.vim"))
vim.cmd("source ".. vim.fs.joinpath(config_dir, "viml_conf/plugin/leaderf.vim"))
-- colorscheme settings
require("colorschemes")
