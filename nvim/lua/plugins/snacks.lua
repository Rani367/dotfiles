return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      -- cap results to keep ui responsive in large repos
      limit = 5000,
      limit_live = 3000,
      matcher = {
        fuzzy = true,
        smartcase = true,
        filename_bonus = true,
        file_pos = true,
        -- disable smart ranking, prefer exact matching
        cwd_bonus = false,
        frecency = false,
        history_bonus = false,
        sort_empty = false,
        ignorecase = true,
      },
      previewers = {
        file = {
          max_size = 512 * 1024,
          max_line_length = 300,
        },
      },
      win = {
        preview = {
          wo = {
            number = false,
            relativenumber = false,
            cursorline = false,
            signcolumn = "no",
            wrap = false,
          },
        },
      },
      sources = {
        files = {
          hidden = false,
          ignored = false,
        },
        grep = {
          hidden = false,
          ignored = false,
          -- perf: limit rg work to avoid freezing on huge repos
          args = {
            "--threads=4",
            "--max-columns=200",
            "--max-columns-preview",
            "--max-filesize=1M",
            "--no-messages",
          },
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
