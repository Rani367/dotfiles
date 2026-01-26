return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keymap = { preset = "super-tab" },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = {
        auto_show = false,
      },
      menu = { auto_show = true },
      ghost_text = { enabled = false },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = { score_offset = 100 },
        snippets = {
          score_offset = 50,
          opts = {
            search_paths = {
              vim.fn.stdpath("config") .. "/snippets",
              vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
            },
          },
        },
        path = { score_offset = 25 },
        buffer = { score_offset = 0 },
      },
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = {
        "score", -- includes frecency bonus
        "sort_text",
        "label",
      },
      frecency = { enabled = true },
      proximity = { enabled = true },
    },
    cmdline = {
      enabled = true,
      completion = {
        menu = { auto_show = true },
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
