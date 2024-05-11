local M = {}

M.ui = {
  theme = "tokyodark",
  cmp = {
    icons = true,
    style = "atom_colored",
    lspkind_text = true,
    source = true,
    border = "single",
  },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  statusline = {
    theme = "minimal",
    disable = { alpha = true },
    separator_style = "arrow",
    overriden_modules = nil,
    tabufline = true,
    winbar = true,
    winbar_filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
    },
  },
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
  },
}

return M
