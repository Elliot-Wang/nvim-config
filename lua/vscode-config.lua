-- VSCode-Neovim specific configuration
-- This file is loaded only when running inside VSCode

local vscode = require('vscode')

-- Disable unnecessary providers in VSCode
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

-- Disable built-in plugins that conflict with VSCode
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

-- Basic options for VSCode
vim.opt.clipboard = 'unnamedplus'

-- VSCode-specific keymaps using VSCode API
local keymap = vim.keymap

-- File operations via VSCode
keymap.set('n', '<leader>w', function() vscode.action('workbench.action.files.save') end, { desc = 'Save file' })
keymap.set('n', '<leader>q', function() vscode.action('workbench.action.closeActiveEditor') end, { desc = 'Close editor' })

-- Navigation via VSCode
keymap.set('n', 'gd', function() vscode.action('editor.action.revealDefinition') end, { desc = 'Go to definition' })
keymap.set('n', 'gr', function() vscode.action('editor.action.goToReferences') end, { desc = 'Go to references' })
keymap.set('n', 'gi', function() vscode.action('editor.action.goToImplementation') end, { desc = 'Go to implementation' })
--keymap.set('n', 'K', function() vscode.action('editor.action.showHover') end, { desc = 'Show hover' })

-- Code actions
keymap.set('n', '<leader>ca', function() vscode.action('editor.action.quickFix') end, { desc = 'Code action' })
keymap.set('n', '<leader>rn', function() vscode.action('editor.action.rename') end, { desc = 'Rename symbol' })
keymap.set('n', '<leader>fm', function() vscode.action('editor.action.formatDocument') end, { desc = 'Format document' })

-- Search via VSCode
keymap.set('n', '<leader>ff', function() vscode.action('workbench.action.quickOpen') end, { desc = 'Find files' })
keymap.set('n', '<leader>fg', function() vscode.action('workbench.action.findInFiles') end, { desc = 'Find in files' })
keymap.set('n', '<leader>fb', function() vscode.action('workbench.action.showAllEditors') end, { desc = 'Find buffers' })

-- File explorer
keymap.set('n', '<leader>e', function() vscode.action('workbench.view.explorer') end, { desc = 'File explorer' })

-- Git operations
keymap.set('n', '<leader>gs', function() vscode.action('workbench.view.scm') end, { desc = 'Git status' })
keymap.set('n', '<leader>gc', function() vscode.action('git.commit') end, { desc = 'Git commit' })
keymap.set('n', '<leader>gp', function() vscode.action('git.push') end, { desc = 'Git push' })

-- Window/Editor management
keymap.set('n', '<C-h>', function() vscode.action('workbench.action.focusLeftGroup') end, { desc = 'Focus left' })
keymap.set('n', '<C-l>', function() vscode.action('workbench.action.focusRightGroup') end, { desc = 'Focus right' })
keymap.set('n', '<C-j>', function() vscode.action('workbench.action.focusBelowGroup') end, { desc = 'Focus below' })
keymap.set('n', '<C-k>', function() vscode.action('workbench.action.focusAboveGroup') end, { desc = 'Focus above' })

-- Diagnostics
keymap.set('n', '[d', function() vscode.action('editor.action.marker.prev') end, { desc = 'Previous diagnostic' })
keymap.set('n', ']d', function() vscode.action('editor.action.marker.next') end, { desc = 'Next diagnostic' })

-- Comment toggle (using VSCode native)
keymap.set({'n', 'v'}, 'gc', function() vscode.action('editor.action.commentLine') end, { desc = 'Toggle comment' })

-- Fold operations
keymap.set('n', 'za', function() vscode.action('editor.toggleFold') end, { desc = 'Toggle fold' })
keymap.set('n', 'zR', function() vscode.action('editor.unfoldAll') end, { desc = 'Unfold all' })
keymap.set('n', 'zM', function() vscode.action('editor.foldAll') end, { desc = 'Fold all' })
