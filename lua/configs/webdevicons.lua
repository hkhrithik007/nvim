local webdevicons_status_ok, webdevicons = pcall(require, "nvim-web-devicons")
if not webdevicons_status_ok then
  return
end
webdevicons.setup({
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh",
    },
  },
})
