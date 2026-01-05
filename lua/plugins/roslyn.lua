return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  dependencies = {
    "saghen/blink.cmp",
  },
  opts = {
    filewatching = "auto",
    broad_search = false,
    lock_target = false,
  },
  config = function(_, opts)
    require("roslyn").setup(opts)
