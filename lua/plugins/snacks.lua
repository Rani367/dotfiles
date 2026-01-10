return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      sources = {
        files = {
          hidden = false,
          ignored = false,
          exclude = { "bin", "obj", "node_modules", ".git" },
