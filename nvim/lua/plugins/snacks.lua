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
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Live Grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Restore Session", action = ":lua Snacks.dashboard.pick('projects')" },
          { icon = "󰒲 ", key = "u", desc = "Update Plugins", action = ":Lazy update" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "terminal", cmd = "git -c color.status=always status -sb 2>/dev/null || echo 'not a git repo'", height = 5, padding = 1, ttl = 5 * 60 },
        { section = "startup" },
      },
    },
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
