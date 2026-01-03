return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      cs = { "csharpier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = function(bufnr)
      -- skip large files
