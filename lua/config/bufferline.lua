require("bufferline").setup {
  options = {
    mode = "tabs",
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = nil,
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "underline",
    },
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 10,
    diagnostics = false,
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true -- use a "true" to enable the default, or set your own character
        },
        {
            filetype = "Vista",
            text = "Vista",
            highlight = "Vista",
            text_align = "left",
            separator = true -- use a "true" to enable the default, or set your own character
        },
        {
            filetype = "qf",
            text = "qf",
            highlight = "qf",
            separator = true -- use a "true" to enable the default, or set your own character
        },
    },
    groups = {
      items = {
        require('bufferline.groups').builtin.pinned:with({ icon = "󰐃 " })
      }
    },
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    custom_filter = function(bufnr)
      -- if the result is false, this buffer will be shown, otherwise, this
      -- buffer will be hidden.

      -- filter out filetypes you don't want to see
      local exclude_ft = { "qf", "fugitive", "git" }
      local cur_ft = vim.bo[bufnr].filetype
      local should_filter = vim.tbl_contains(exclude_ft, cur_ft)

      if should_filter then
        return false
      end

      return true
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = "id",
  },
}

vim.keymap.set("n", "gt", "<cmd>BufferLinePick<CR>", {
  desc = "pick a buffer",
})
