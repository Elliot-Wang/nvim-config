require("obsidian").setup {
  workspaces = _G.obsidian_opt_workspace,

  -- Preserve all existing frontmatter fields, just skip auto-generated id
  note_frontmatter_func = function(note)
    local out = {}

    -- Keep all existing metadata fields
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end

    if note.tags ~= nil and not vim.tbl_isempty(note.tags) then
      out.tags = note.tags
    end
    if note.aliases ~= nil and not vim.tbl_isempty(note.aliases) then
      out.aliases = note.aliases
    end

    return out
  end,

  -- Optional, configure additional syntax highlighting / extmarks.
  -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
  ui = {
    enable = false,
  },

  daily_notes = {
    folder = "200 Journal/210 Daily",       -- 日记存放路径（相对 vault 根）
    date_format = "%y-%m-%d_%a",       -- 文件名格式，如 26-05-08_Fri.md
    alias_format = "%B %-d, %Y",    -- 别名格式，如 "May 8, 2026"
    default_tags = { "daily" },     -- 新建日记自动加的 tag
    template = "Daily Log Template.md",          -- 新建时自动套用的模板文件（从 templates.folder 读取）
  },

  -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
  -- way then set 'mappings = {}'.
  mappings = {
    -- Overrides the 'gd' mapping to work on markdown/wiki links within your vault.
    ["gd"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Table of contents for the current note.
    ["gt"] = {
      action = function()
        return vim.cmd("ObsidianTOC")
      end,
      opts = { buffer = true },
    },
    -- Quick switch to another note in the vault.
    ["gf"] = {
      action = function()
        return vim.cmd("ObsidianQuickSwitch")
      end,
      opts = { buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    }
  },

  -- Optional, for templates (see below).
  templates = {
    folder = "000 Meta/010 Template",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },
}
