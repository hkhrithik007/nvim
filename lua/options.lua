require "nvchad.options"

-- add yours here!
-- vim.cmd "colorscheme cyberdream"
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true
vim.opt.relativenumber = true
vim.o.cmdheight = 0
vim.opt.clipboard = "unnamedplus"
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format { bufnr = args.buf }
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })
