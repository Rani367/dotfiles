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
