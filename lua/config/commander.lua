local commander = require("commander")

commander.add({
  {
    desc = "Search inside current buffer",
    cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
    keys = { "n", "<leader>fl" },
  }, {
  -- If desc is not provided, cmd is used to replace descirption by default
  -- You can change this behavior in setup()
  cmd = "<CMD>Telescope find_files<CR>",
  keys = { "n", "<leader>ff" },
}, {
  -- You can specify multiple keys for the same cmd ...
  desc = "Show document symbols",
  cmd = "<CMD>Telescope lsp_document_symbols<CR>",
  keys = {
    { "n", "<leader>ss",  { noremap = true } },
    { "n", "<leader>ssd", { noremap = true } },
  },
}, {
  -- ... and for different modes
  desc = "Show function signaure (hover)",
  cmd = "<CMD>lua vim.lsp.buf.hover()<CR>",
  keys = {
    { { "n", "x" }, "K",  silent_noremap },
    { "i",        "<C-k>" },
  }
}, {
  -- You can pass in a key sequences as if you would type them in nvim
  desc = "My favorite key sequence",
  cmd = "A  -- Add a comment at the end of a line",
  keys = { "n", "<leader>Ac" }
}, {
  -- You can also pass in a lua functions as cmd
  -- NOTE: binding lua funciton to a keymap requires nvim >= 0.7
  desc = "Run lua function",
  cmd = function() print("ANONYMOUS LUA FUNCTION") end,
  keys = { "n", "<leader>alf" },
}, 
})