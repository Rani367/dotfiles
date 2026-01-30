return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      limit = 10000,
      limit_live = 10000,
      matcher = {
        fuzzy = true,
        smartcase = true,
        filename_bonus = true,
        file_pos = true,
        cwd_bonus = false,
        frecency = false,
        history_bonus = false,
      },
      sources = {
        files = {
          hidden = false,
          ignored = false,
          exclude = { "bin", "obj", "node_modules", ".git", "build", "dist", "target", ".cache", "vendor", "__pycache__", ".next", ".nuxt", "coverage", ".venv", "venv" },
        },
        grep = {
          hidden = false,
          ignored = false,
          exclude = { "bin", "obj", "node_modules", ".git", "build", "dist", "target", ".cache", "vendor", "__pycache__", ".next", ".nuxt", "coverage", ".venv", "venv" },
        },
        buffers = {
          format = "file",
          transform = function(item)
            item.pos = nil
          end,
        },
      },
    },
    terminal = { enabled = true },
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
}
