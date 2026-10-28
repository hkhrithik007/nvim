local split = require "smart-splits"

-- Smart Splits configuration
split.setup {
  -- Buffer types to ignore when navigating or resizing
  ignored_buftypes = {
    "nofile",
    "quickfix",
    "prompt",
  },

  -- Filetypes to ignore
  ignored_filetypes = {
    "NvimTree",
  },

  -- Split resizing
  resize = {
    amount = 3,
  },

  -- Window navigation
  move = {
    at_edge = "wrap",
    same_row = false,
  },

  -- Buffer swapping
  swap = {
    move_cursor = false,
  },

  -- Logging
  log = {
    level = "info",
  },
}

-- Resize splits
vim.keymap.set("n", "<C-a>", split.resize_left, {
  desc = "Resize split left",
})

vim.keymap.set("n", "<C-s>", split.resize_down, {
  desc = "Resize split down",
})

-- Use Ctrl+Up instead of Ctrl+W to preserve Neovim's
-- standard <C-w> window-command prefix.
vim.keymap.set("n", "<C-Up>", split.resize_up, {
  desc = "Resize split up",
})

vim.keymap.set("n", "<C-d>", split.resize_right, {
  desc = "Resize split right",
})

-- Move between splits
vim.keymap.set("n", "<C-h>", split.move_cursor_left, {
  desc = "Move to split left",
})

vim.keymap.set("n", "<C-j>", split.move_cursor_down, {
  desc = "Move to split below",
})

vim.keymap.set("n", "<C-k>", split.move_cursor_up, {
  desc = "Move to split above",
})

vim.keymap.set("n", "<C-l>", split.move_cursor_right, {
  desc = "Move to split right",
})
