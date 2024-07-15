local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup({
	-- Enable comment.nvim
	active = true,

	-- Define basic commenting strategy
	toggler = {
		-- Line-comment toggle keymap
		line = "ccc",
		-- Block-comment toggle keymap
		block = "cbc",
	},

	-- Define operator-pending mappings
	opleader = {
		-- Line-comment keymap
		line = "cc",
		-- Block-comment keymap
		block = "cb",
	},

	-- Define extra mappings
	extra = {
		-- Add comment on the line above
		above = "ccO",
		-- Add comment on the line below
		below = "cco",
		-- Add comment at the end of line
		eol = "ccA",
	},

	-- Enable sticky comments
	sticky = true,

	-- Lines to be ignored while (un)comment
	ignore = "^$",

	-- Enable keybindings
	-- NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		-- Operator-pending mapping; `ccc` `cbc` `cc[count]{motion}` `cb[count]{motion}`
		basic = true,
		-- Extra mapping; `cco`, `ccO`, `ccA`
		extra = true,
	},

	-- Function to call before (un)comment
	pre_hook = nil,

	-- Function to call after (un)comment
	post_hook = nil,
})

-- Optionally, you can set up which-key integration
local status_ok, which_key = pcall(require, "which-key")
if status_ok then
	which_key.register({
		["cc"] = { name = "Comment" },
		["ccc"] = "Toggle comment line",
		["cbc"] = "Toggle block comment",
	}, { mode = "n" })
end
