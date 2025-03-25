vim.keymap.set({ "n" }, "<leader>bk", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set({ "n" }, "<leader>dr", "<cmd>lua require'dap'.eval()<CR>")
vim.keymap.set({ "n" }, "<leader>d9", "<cmd>lua require'dap'.continue()<CR>")
-- { "n", "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>",         desc = "Step Over" },
-- { "n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>",         desc = "Step Into" },
-- { "n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>",          desc = "Step Out" },
-- { "n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>",          desc = "Run Last" },
