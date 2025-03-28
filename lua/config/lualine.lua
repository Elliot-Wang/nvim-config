local fn = vim.fn

local function spell()
  if vim.o.spell then
    return string.format("[SPELL]")
  end

  return ""
end

--- show indicator for Chinese IME
local function ime_state()
  if vim.g.is_mac then
    -- ref: https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/xkblayout.vim#L11
    local layout = fn.libcall(vim.g.XkbSwitchLib, "Xkb_Switch_getXkbLayout", "")

    -- We can use `xkbswitch -g` on the command line to get current mode.
    -- mode for macOS builtin pinyin IME: com.apple.inputmethod.SCIM.ITABC
    -- mode for Rime: im.rime.inputmethod.Squirrel.Rime
    local res = fn.match(layout, [[\v(Squirrel\.Rime|SCIM.ITABC)]])
    if res ~= -1 then
      return "[CN]"
    end
  end

  return ""
end

local function trailing_space()
  if not vim.o.modifiable then
    return ""
  end

  local line_num = nil

  for i = 1, fn.line("$") do
    local linetext = fn.getline(i)
    -- To prevent invalid escape error, we wrap the regex string with `[[]]`.
    local idx = fn.match(linetext, [[\v\s+$]])

    if idx ~= -1 then
      line_num = i
      break
    end
  end

  local msg = ""
  if line_num ~= nil then
    msg = string.format("[%d]trailing", line_num)
  end

  return msg
end

local function mixed_indent()
  if not vim.o.modifiable then
    return ""
  end

  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = fn.search(space_pat, "nwc")
  local tab_indent = fn.search(tab_pat, "nwc")
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = fn.search([[\v^(\t+ | +\t)]], "nwc")
    mixed = mixed_same_line > 0
  end
  if not mixed then
    return ""
  end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return "MI:" .. mixed_same_line
  end
  local space_indent_cnt = fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return "MI:" .. tab_indent
  else
    return "MI:" .. space_indent
  end
end

local diff = function()
  local git_status = vim.b.gitsigns_status_dict
  if git_status == nil then
    return
  end

  local modify_num = git_status.changed
  local remove_num = git_status.removed
  local add_num = git_status.added

  local info = { added = add_num, modified = modify_num, removed = remove_num }
  -- vim.print(info)
  return info
end

local virtual_env = function()
  -- only show virtual env for Python
  if vim.bo.filetype ~= "python" then
    return ""
  end

  local conda_env = os.getenv("CONDA_DEFAULT_ENV")
  local venv_path = os.getenv("VIRTUAL_ENV")

  if venv_path == nil then
    if conda_env == nil then
      return ""
    else
      return string.format("  %s (conda)", conda_env)
    end
  else
    local venv_name = vim.fn.fnamemodify(venv_path, ":t")
    return string.format("  %s (venv)", venv_name)
  end
end

local get_active_lsp = function()
  local msg = ""
  local buf_ft = vim.api.nvim_get_option_value("filetype", {})
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    ---@diagnostic disable-next-line: undefined-field
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

-- [nvim-lualine/lualine.nvim: A blazing fast and easy to configure neovim statusline plugin written in pure lua.](https://github.com/nvim-lualine/lualine.nvim)
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    section_separators = "",
    component_separators = "",
    disabled_filetypes = {
      statusline = {
        'qf',
        'minimap',
        'neo-tree',
        'vista',
      },
    },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "branch",
        fmt = function(name, _)
          -- truncate branch name in case the name is too long
          return string.sub(name, 1, 20)
        end,
      },
      {
        virtual_env,
        color = { fg = "black", bg = "#F1CA81" },
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,      -- Displays file status (readonly status, modified status)
        newfile_status = false,  -- Display new file status (new file means no write after created)
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[RO]',     -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
          newfile = '[New]',     -- Text to show for newly created file before first write
        },
      },
      {
        "diff",
        source = diff,
      },
      {
        ime_state,
        color = { fg = "black", bg = "#f46868" },
      },
      {
        spell,
        color = { fg = "black", bg = "#a7c080" },
      },
    },
    lualine_x = {
      {
        get_active_lsp,
        icon = " LSP:",
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = "🆇 ", warn = "⚠️ ", info = "ℹ️ ", hint = " " },
      },
    },
    lualine_y = {
      {
        "fileformat",
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
      "encoding",
      "filetype",
    },
    lualine_z = {
      "progress"
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", "fugitive", "nvim-tree", "nvim-dap-ui" },
}
