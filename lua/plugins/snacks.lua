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
