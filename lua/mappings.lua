require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
map("n", "<leader>lt", "<cmd>LiveServerStart<CR>", { desc = "Lazygit" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Lazygit" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- map("n", "<leader>q", "<cmd>q!<CR>", { desc = "quit" })
-- map("n", "<leader>w", "<cmd>w!<CR>", { desc = "save" })
-- map(
--   "n",
--   "<leader>tt",
--   ":lua require('base46').toggle_transparency()<CR>",
--   { noremap = true, silent = true, desc = "Toggle Background Transparency" }
-- )
