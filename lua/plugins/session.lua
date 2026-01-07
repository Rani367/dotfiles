return {
  "stevearc/resession.nvim",
  lazy = false,
  opts = {
    autosave = {
      enabled = true,
      interval = 60,
      notify = false,
    },
    options = {
      "binary", "bufhidden", "buflisted", "diff", "filetype",
      "foldcolumn", "foldexpr", "foldlevel", "foldmethod",
      "foldminlines", "foldnestmax", "foldtext",
      "list", "modifiable", "previewwindow", "readonly",
      "scrollbind", "shiftwidth", "spell", "tabstop",
      "winfixheight", "winfixwidth", "wrap",
    },
