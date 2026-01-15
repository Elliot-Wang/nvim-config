local utils = require("utils")

-- Helper variable for conditional plugin loading
local not_vscode = not vim.g.vscode

local plugin_dir = vim.fn.stdpath("data") .. "/lazy"
local lazypath = plugin_dir .. "/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local plugin_specs = {}

local function addPlugins(plugs)
  for k, v in pairs(plugs) do
    table.insert(plugin_specs, v)
  end
end

-- plugins define
local function syntaxPlugs()
  addPlugins({
    -- beancount
    { "nathangrigg/vim-beancount", ft = { "beancount" } },
    -- toml
    { "cespare/vim-toml",          ft = { "toml" },     branch = "main" },
    {
      "romgrk/nvim-treesitter-context",
      cond = not_vscode,
      config = function()
        require("treesitter-context").setup {
          enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
          throttle = true, -- Throttles plugin updates (may improve performance)
          max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
          patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
              'class',
              'function',
              'method',
            },
          },
        }
      end
    },
    -- common
    {
      "nvim-treesitter/nvim-treesitter",
      cond = not_vscode,
      enabled = function()
        if vim.g.is_mac then
          return true
        end
        -- Windows support
        -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
        return false
      end,
      event = "VeryLazy",
      build = ":TSUpdate",
      config = function()
        require("config.treesitter")
      end,
    },
  })
end

local function colorschemePlugs()
  addPlugins({
    -- A list of colorscheme plugin you may want to try. Find what suits you.
    { "navarasu/onedark.nvim",       lazy = true, cond = not_vscode },
    { "sainnhe/edge",                lazy = true, cond = not_vscode },
    { "sainnhe/sonokai",             lazy = true, cond = not_vscode },
    { "sainnhe/gruvbox-material",    lazy = true, cond = not_vscode },
    { "sainnhe/everforest",          lazy = true, cond = not_vscode },
    { "EdenEast/nightfox.nvim",      lazy = true, cond = not_vscode },
    { "catppuccin/nvim",             name = "catppuccin", lazy = true, cond = not_vscode },
    { "olimorris/onedarkpro.nvim",   lazy = true, cond = not_vscode },
    { "marko-cerovac/material.nvim", lazy = true, cond = not_vscode },
    { "dracula/vim",                 name = "dracula",    lazy = true, cond = not_vscode },
    {
      "rockyzhang24/arctic.nvim",
      cond = not_vscode,
      dependencies = { "rktjmp/lush.nvim" },
      name = "arctic",
      branch = "v2",
    },
    { "rebelot/kanagawa.nvim", lazy = true, cond = not_vscode },
  })
end

local function gitPlugs()
  addPlugins({
    -- Git command inside vim (keep for VSCode)
    {
      "tpope/vim-fugitive",
      event = "User InGitRepo",
      config = function()
        require("config.fugitive")
      end,
    },

    -- Better git log display
    { "rbong/vim-flog",            cmd = { "Flog" }, cond = not_vscode },
    { "akinsho/git-conflict.nvim", version = "*",   config = true },
    {
      "ruifm/gitlinker.nvim",
      cond = not_vscode,
      event = "User InGitRepo",
      config = function()
        require("config.git-linker")
      end,
    },

    -- Show git change (change, delete, add) signs in vim sign column (keep for VSCode)
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("config.gitsigns")
      end,
    },

    {
      "sindrets/diffview.nvim",
      cond = not_vscode,
    },
    {
      "kdheepak/lazygit.nvim",
      cond = not_vscode,
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
      build = function()
        -- 判断是否为 macOS 且未安装 lazygit
        if vim.fn.has("mac") == 1 and vim.fn.executable("lazygit") == 0 then
          print("正在通过 Homebrew 安装 lazygit...")
          vim.fn.system({ "brew", "install", "lazygit" })
        end
      end,
      -- setting the keybinding for LazyGit with 'keys' is recommended in
      -- order to load the plugin when the command is run for the first time
      keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
      }
    },
  })
end

local function textObjectPlugs()
  addPlugins({
    -- Python-related text object
    { "jeetsukumaran/vim-pythonsense",   ft = { "python" } },

    -- Add indent object for vim (useful for languages like Python)
    { "michaeljsmith/vim-indent-object", event = "VeryLazy" },
  })
end

local function linkPlugs()
  addPlugins({
    -- Highlight URLs inside vim
    { "itchyny/vim-highlighturl", event = "VeryLazy" },

    -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
    -- not be possible since we maybe in a server which disables GUI.
    {
      "chrishrb/gx.nvim",
      cond = not_vscode,
      keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
      cmd = { "Browse" },
      init = function()
        vim.g.netrw_nogx = 1 -- disable netrw gx
      end,
      enabled = function()
        if vim.g.is_win or vim.g.is_mac then
          return true
        else
          return false
        end
      end,
      dependencies = { "nvim-lua/plenary.nvim" },
      config = true,      -- default settings
      submodules = false, -- not needed, submodules are required only for tests
    },

  })
end

local function helperPlugs()
  addPlugins({
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      },
    },
    -- fancy start screen
    {
      "nvimdev/dashboard-nvim",
      cond = not_vscode,
      config = function()
        require("config.dashboard-nvim")
      end,
    },

    -- fold
    {
      "kevinhwang91/nvim-ufo",
      cond = not_vscode,
      dependencies = "kevinhwang91/promise-async",
      event = "VeryLazy",
      opts = {},
      init = function()
        vim.o.foldcolumn = "1" -- '0' is not bad
        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
      end,
      config = function()
        require("config.nvim_ufo")
      end,
    },

    -- fold sign is clickable
    {
      "luukvbaal/statuscol.nvim",
      cond = not_vscode,
      opts = {},
      config = function()
        require("config.nvim-statuscol")
      end,
    },

    -- Modern matchit implementation (keep for VSCode)
    {
      "andymass/vim-matchup",
      event = "CursorMoved",
      config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },

    -- Autosave files on certain events (keep for VSCode)
    { "907th/vim-auto-save", event = "InsertEnter" },

    -- Manage your yank history (keep for VSCode)
    {
      "gbprod/yanky.nvim",
      config = function()
        require("config.yanky")
      end,
      event = "VeryLazy",
    },

    -- Session management plugin
    { "tpope/vim-obsession", cmd = "Obsession", cond = not_vscode },

    -- yank history manager for linux
    {
      "ojroques/vim-oscyank",
      cond = not_vscode,
      enabled = function()
        if vim.g.is_linux then
          return true
        end
        return false
      end,
      cmd = { "OSCYank", "OSCYankReg" },
    },

    -- showing keybindings
    {
      "folke/which-key.nvim",
      cond = not_vscode,
      enabled = false,
      event = "VeryLazy",
      config = function()
        require("config.which-key")
      end,
    },
    -- hop for quick navigation (keep for VSCode)
    {
      "smoka7/hop.nvim",
      event = "BufRead",
      config = function()
        require("config.nvim_hop")
      end,
    },

    -- show global result while edit command
    {
      "smjonas/live-command.nvim",
      cond = not_vscode,
      -- live-command supports semantic versioning via Git tags
      -- tag = "2.*",
      cmd = "Preview",
      config = function()
        require("config.live-command")
      end,
      event = "VeryLazy",
    },

    -- Asynchronous command execution
    { "skywind3000/asyncrun.vim", lazy = true, cmd = { "AsyncRun" }, cond = not_vscode },

    {
      "keaising/im-select.nvim",
      cond = not_vscode,
      enabled = function()
        if utils.executable('im-select') then
          return true
        else
          return false
        end
      end,
      config = function()
        require("im_select").setup({
          -- IM will be set to `default_im_select` in `normal` mode
          default_im_select   = "com.apple.keylayout.ABC",

          -- Restore the default input method state when the following events are triggered
          set_default_events  = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

          -- Restore the previous used input method state when the following events
          -- are triggered, if you don't want to restore previous used im in Insert mode,
          -- just let it empty
          set_previous_events = { "InsertEnter" },

          -- Async run `default_command` to switch IM or not
          async_switch_im     = true,
        })
      end,
    },

    {
      "lyokha/vim-xkbswitch",
      cond = not_vscode,
      enabled = function()
        if vim.g.is_mac and utils.executable("xkbswitch") then
          return true
        end
        return false
      end,
      event = { "InsertEnter" },
    },

  })
end

local function stringManipulatePlugs()
  addPlugins({
    -- Comment plugin
    { "tpope/vim-commentary", event = "VeryLazy" },

    -- Multiple cursor plugin like Sublime Text?
    -- 'mg979/vim-visual-multi'

    -- Repeat vim motions
    { "tpope/vim-repeat",     event = "VeryLazy" },

    -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    { "godlygeek/tabular",    cmd = { "Tabularize" } },

    "tpope/vim-surround",

    -- Automatic insertion and deletion of a pair of characters
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
    },

    "terryma/vim-multiple-cursors",

    {
      "junegunn/vim-easy-align",
      keys = {
        { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } }
      },
    }
  })
end

local function sidebarPlugs()
  addPlugins({
    -- file explorer
    -- {
    --   "nvim-tree/nvim-tree.lua",
    --   enabled = false,
    --   event = "VeryLazy",
    --   dependencies = { "nvim-tree/nvim-web-devicons" },
    --   config = function()
    --     require("config.nvim-tree")
    --   end,
    --   attach = function(bufnr)
    --     local api = require "nvim-tree.api"

    --     local function opts(desc)
    --       return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    --     end

    --     -- default mappings
    --     api.config.mappings.default_on_attach(bufnr)

    --     -- custom mappings
    --     -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    --     vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    --   end,
    -- },

    {
      "nvim-neo-tree/neo-tree.nvim",
      cond = not_vscode,
      branch = "v2.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("config.neotree")
      end
    },

    -- Only install these plugins if ctags are installed on the system
    -- show file tags in vim window
    {
      "liuchengxu/vista.vim",
      cond = not_vscode,
      enabled = function()
        if utils.executable("ctags") then
          return true
        else
          return false
        end
      end,
      cmd = "Vista",
    },

    -- Show undo history visually
    { "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" }, cond = not_vscode },

    {
      "kevinhwang91/nvim-bqf",
      cond = not_vscode,
      event = { "BufRead", "BufNew" },
      ft = "qf",
      config = function()
        require("bqf").setup({
          auto_enable = true,
          preview = {
            win_height = 12,
            win_vheight = 12,
            delay_syntax = 80,
            border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
          },
          func_map = {
            vsplit = "",
            ptogglemode = "z,",
            stoggleup = "",
          },
          filter = {
            fzf = {
              action_for = { ["ctrl-s"] = "split" },
              extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
            },
          },
        })
      end,
    },

    -- minimap
    {
      "wfxr/minimap.vim",
      cond = not_vscode,
      enabled = function()
        if utils.executable("code-minimap") then
          return true
        else
          return false
        end
      end,
      config = function()
        vim.cmd [[
          let g:minimap_width = 10
          let g:minimap_auto_start = 1
          let g:minimap_auto_start_win_enter = 1
        ]]
      end,
    },

  })
end


local function snippetPlugs()
  addPlugins({
    -- Snippet engine and snippet template
    {
      "SirVer/ultisnips",
      cond = not_vscode,
      dependencies = {
        "honza/vim-snippets",
      },
      event = "InsertEnter",
      ft = "snippets",
      config = function()
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = "*.snippets",
          group = vim.api.nvim_create_augroup("ultisnips", { clear = true }),
          desc = "autoresize windows on resizing operation",
          callback = function()
            vim.cmd("CmpUltisnipsReloadSnippets")
            vim.notify("Ultisnips reloaded.", vim.log.levels.INFO, { title = "nvim-config" })
          end
        })
      end
    },
  })
end

local function completionPlugs()
  addPlugins({
    -- auto-completion engine
    {
      "iguanacucumber/magazine.nvim",
      cond = not_vscode,
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
    -- The missing auto-completion for cmdline!
    {
      "gelguy/wilder.nvim",
      cond = not_vscode,
      build = ":UpdateRemotePlugins",
    },
  })
end

local function lspPlugs()
  addPlugins({
    -- debugger
    {
      'mfussenegger/nvim-dap',
      cond = not_vscode,
      config = function()
        require("config.nvim-dap")
      end
    },
    {
      "rcarriga/nvim-dap-ui",
      cond = not_vscode,
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      config = function()
        require("config.nvim-dap-ui")
      end
    },
    {
      "leoluz/nvim-dap-go",
      cond = not_vscode,
      dependencies = { "mfussenegger/nvim-dap" },
      enabled = function()
        if utils.executable('go') then
          return true
        else
          return false
        end
      end,
      config = function()
        require("config.dap.nvim-dap-go")
      end
    },
    {
      "mfussenegger/nvim-dap-python",
      cond = not_vscode,
      dependencies = { "mfussenegger/nvim-dap" },
      enabled = function()
        if utils.executable('debugpy') then
          return true
        else
          return false
        end
      end,
      config = function()
        require("config.dap.nvim-dap-python")
      end
    },

    -- lsp config
    {
      "neovim/nvim-lspconfig",
      cond = not_vscode,
      event = { "BufRead", "BufNewFile" },
      config = function()
        require("config.lsp")
      end,
    },

    {
      "coder/claudecode.nvim",
      cond = vim.g.is_mac,
      dependencies = { "folke/snacks.nvim" },
      cmd = { "ClaudeCode", "ClaudeCodeStart" },
      opts = {
        terminal_cmd = "/opt/homebrew/bin/claude", -- Point to local installation
      },
      config = true,
      keys = {
        { "<leader>a", nil, desc = "AI/Claude Code" },
        -- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        -- focus management
        { "<C-]>", "<cmd>ClaudeCodeFocus<cr>", mode="n", desc = "Focus Claude" },
        { "<C-]>", [[<c-\><c-n><cmd>ClaudeCodeFocus<cr>]], mode="t", desc = "Close Claude" },
        -- send to claude
        --{ "<leader>as", "<cmd>ClaudeCodeAdd %<cr><cmd>ClaudeCodeFocus<cr>", mode="n", desc = "Add current buffer and chat" },
        { "<leader>as", "<cmd>ClaudeCodeAdd %<cr>", mode="n", desc = "Add current buffer" },
        --{ "<leader>as", "<cmd>ClaudeCodeSend<cr><cmd>ClaudeCodeFocus<cr>", mode = "v", desc = "Send to Claude and chat" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
        { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file",
          ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        },
        -- Diff management
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
      }
    },

    -- Auto format tools
    -- supports https://github.com/sbdchd/neoformat?tab=readme-ov-file#supported-filetypes
    { "sbdchd/neoformat", cmd = { "Neoformat" }, cond = not_vscode },

    {
      -- show hint for code actions, the user can also implement code actions themselves,
      -- see discussion here: https://github.com/neovim/neovim/issues/14869
      "kosayoda/nvim-lightbulb",
      cond = not_vscode,
      config = function()
        require("nvim-lightbulb").setup { autocmd = { enabled = true } }
      end,
    },

    -- lsp servers --
    {
      'nvim-java/nvim-java',
      ft = {
        "java", "groovy"
      },
      config = function()
        require('java').setup()
        vim.lsp.enable('jdtls')
      end,
    },

    {
      "folke/lazydev.nvim",
      cond = not_vscode,
      ft = "lua", -- only load on lua files
      opts = {},
    },

    {
      "ray-x/go.nvim",
      cond = not_vscode,
      enabled = function()
        if utils.executable('go') then
          return true
        else
          return false
        end
      end,
      dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = { "CmdlineEnter" },
      ft = { "go", 'gomod' },
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
  })
end

local function markdownPlugs()
  addPlugins({
    {
      "MeanderingProgrammer/markdown.nvim",
      cond = not_vscode,
      main = "render-markdown",
      opts = {},
      dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    },
    -- Another markdown plugin
    { "preservim/vim-markdown", ft = { "markdown" }, cond = not_vscode },

    -- Faster footnote generation
    -- { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } },

    -- Markdown previewing (only for Mac and Windows)
    {
      "iamcco/markdown-preview.nvim",
      cond = not_vscode,
      enabled = function()
        if vim.g.is_win or vim.g.is_mac then
          return true
        end
        return false
      end,
      build = "cd app && npm install",
      config = function()
        vim.cmd [[
          let g:mkdp_browser = '/Applications/Safari.app'

          " Do not close the preview tab when switching to other buffers
          let g:mkdp_auto_close = 0

          " Shortcuts to start and stop markdown previewing
          nnoremap <silent> <M-m> :<C-U>MarkdownPreview<CR>
        ]]
      end,
      ft = { "markdown" },
    },
    {
      "rhysd/vim-grammarous",
      cond = not_vscode,
      enabled = function()
        -- if vim.g.is_mac then
        --   return true
        -- end
        return false
      end,
      ft = { "markdown" },
    },
    {
      "epwalsh/obsidian.nvim",
      cond = not_vscode,
      version = "*", -- recommended, use latest release instead of latest commit
      enabled = function()
        return _G.enable_obsidian
      end,
      config = function()
        require("config.obsidian")
      end,
      ft = "markdown",
      -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
      -- event = {
      --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      --   -- refer to `:h file-pattern` for more examples
      --   "BufReadPre Obsidian/*.md",
      --   "BufNewFile Obsidian/*.md",
      -- },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
  })
end

local function ungroupPlugs()
  addPlugins({
    -- show and trim trailing whitespaces
    { "jdhao/whitespace.nvim", enabled = false,                               event = "VeryLazy" },

    -- Handy unix command inside Vim (Rename, Move etc.)
    { "tpope/vim-eunuch",      cmd = { "Rename", "Delete" } },

    -- a Vim plugin for making Vim plugins
    { "tpope/vim-scriptease",  cmd = { "Scriptnames", "Messages", "Verbose" } },

  })
end

local function searchPlugs()
  addPlugins({
    -- Show match number and index for searching (keep for VSCode)
    {
      "kevinhwang91/nvim-hlslens",
      branch = "main",
      keys = { "*", "#", "n", "N" },
      config = function()
        require("config.hlslens")
      end,
    },
    {
      "folke/todo-comments.nvim",
      cond = not_vscode,
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "Yggdroot/LeaderF",
      cond = not_vscode,
      cmd = "Leaderf",
      build = function()
        local leaderf_path = plugin_dir .. "/LeaderF"
        vim.opt.runtimepath:append(leaderf_path)
        vim.cmd("runtime! plugin/leaderf.vim")

        if not vim.g.is_win then
          vim.cmd("LeaderfInstallCExtension")
        end
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      cond = not_vscode,
      -- cmd = "Telescope",
      dependencies = {
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("config.telescope")
      end,
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      cond = not_vscode,
      config = function()
        require("telescope").load_extension("frecency")
      end,
    },
    {
      'nvim-telescope/telescope-project.nvim',
      cond = not_vscode,
      dependencies = {
        'nvim-telescope/telescope.nvim',
      },
      config = function()
        require("config.telescope-project")
      end
    },
    {
      -- :Telescope media_files
      'nvim-telescope/telescope-media-files.nvim',
      cond = not_vscode,
      enabled = false,
      config = function()
        require('telescope').load_extension('media_files')
      end
    },
    {
      'dhruvmanila/browser-bookmarks.nvim',
      cond = not_vscode,
      version = '*',
      -- Only required to override the default options
      opts = {
        -- Override default configuration values
        selected_browser = 'arc'
      },
    },
    { 'crispgm/telescope-heading.nvim', cond = not_vscode },
    {
      {
        "FeiyouG/commander.nvim",
        cond = not_vscode,
        config = function()
          require('config.commander')
        end
      },
      -- dependencies = {
      --   -- Only if your selected browser is Firefox, Waterfox or buku
      --   'kkharji/sqlite.lua',
      --
      --   -- Only if you're using the Telescope extension
      --   'nvim-telescope/telescope.nvim',
      -- }
    },
    -- {
    --   "ibhagwan/fzf-lua",
    --   -- optional for icon support
    --   dependencies = { "nvim-tree/nvim-web-devicons" },
    --   config = function()
    --     -- calling `setup` is optional for customization
    --     require("fzf-lua").setup {}
    --   end,
    -- },
  })
end

local function uiPlugs()
  addPlugins({
    { "nvim-tree/nvim-web-devicons", event = "VeryLazy", cond = not_vscode },

    {
      "nvim-lualine/lualine.nvim",
      cond = not_vscode,
      event = "VeryLazy",
      config = function()
        require("config.lualine")
      end,
    },

    {
      "akinsho/bufferline.nvim",
      cond = not_vscode,
      event = { "BufEnter" },
      config = function()
        require("config.bufferline")
      end,
    },

    -- Extensible UI for Neovim notifications and LSP progress messages.
    {
      "j-hui/fidget.nvim",
      cond = not_vscode,
      enabled = false,
      event = "VeryLazy",
      tag = "legacy",
      config = function()
        require("config.fidget-nvim")
      end,
    },

    -- notification plugin
    {
      "rcarriga/nvim-notify",
      cond = not_vscode,
      -- event = "VeryLazy",
      config = function()
        require("config.nvim-notify")
      end,
    },

    -- better UI for some nvim actions
    { "stevearc/dressing.nvim", cond = not_vscode },

    {
      "lukas-reineke/indent-blankline.nvim",
      cond = not_vscode,
      event = "VeryLazy",
      main = "ibl",
      config = function()
        require("config.indent-blankline")
      end,
    },

    {
      "tribela/transparent.nvim",
      cond = not_vscode,
      enabled = _G.enable_transparent,
    },
  })
end

local function fileBrowserPlugs()
  addPlugins({
    -- yazi <C-c> to close
    {
      "mikavilpas/yazi.nvim",
      cond = not_vscode,
      event = "VeryLazy",
      keys = {
        {
          -- NOTE: this requires a version of yazi that includes
          -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
          "gy",
          "<cmd>Yazi toggle<cr>",
          desc = "Open yazi at the current file",
        },
        {
          -- Open in the current working directory
          "<leader>cw",
          "<cmd>Yazi cwd<cr>",
          desc = "Open the file manager in nvim's working directory",
        },
      },
      opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = false,
        keymaps = {
          show_help = '<f1>',
          open_file_in_vertical_split = '<c-v>',
          open_file_in_horizontal_split = '<c-x>',
          open_file_in_tab = '<c-t>',
          grep_in_directory = '<c-s>',
          replace_in_directory = '<c-g>',
          cycle_open_buffers = '<tab>',
          copy_relative_path_to_selected_files = '<c-y>',
          send_to_quickfix_list = '<c-q>',
          change_working_directory = "<c-\\>",
        },
      },
    },
  })
end

local function tmplatePlugs()
  addPlugins({
  })
end

-- apply plugins --
syntaxPlugs()
colorschemePlugs()
gitPlugs()
textObjectPlugs()
linkPlugs()
helperPlugs()
stringManipulatePlugs()
snippetPlugs()
sidebarPlugs()
completionPlugs()
lspPlugs()
markdownPlugs()
searchPlugs()
uiPlugs()
fileBrowserPlugs()
ungroupPlugs()

require("lazy").setup {
  spec = plugin_specs,
  ui = {
    border = "rounded",
    title = "Plugin Manager",
    title_pos = "center",
  },
  rocks = {
    enabled = false,
  },
}
