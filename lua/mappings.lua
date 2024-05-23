require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
map("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
map("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i")
map("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i")
map("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i")
map("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>i")
-- Expand `cc` into CodeCompanion in the command line
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.keymap.set("n", "<C-a>", require("smart-splits").resize_left)
vim.keymap.set("n", "<C-s>", require("smart-splits").resize_down)
vim.keymap.set("n", "<C-w>", require("smart-splits").resize_up)
vim.keymap.set("n", "<C-d>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
vim.keymap.set("n", "<leader>R", ":IncRename ")
