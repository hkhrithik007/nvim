local M = {}

M.ui = {
	theme = "chadracula-evondev",
	transparency = true,
	cmp = {
		icons = true,
		style = "default",
		lspkind_text = true,
		source = true,
		border = "single",
	},
	-- telescope = { style = "bordered" },
	lsp = { signature = true },
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
	-- statusline = {
	-- 	theme = "minimal",
	-- 	disable = { alpha = true },
	-- 	separator_style = "arrow",
	-- 	overriden_modules = nil,
	-- 	tabufline = true,
	-- 	winbar = true,
	-- 	winbar_filetype_exclude = {
	-- 		"help",
	-- 		"startify",
	-- 		"dashboard",
	-- 		"packer",
	-- 		"neogitstatus",
	-- 	},
	-- },
	tabufline = {
		enabled = true,
		lazyload = true,
		order = { "treeOffset", "buffers", "tabs", "btns" },
		modules = nil,
	},
}

return M
