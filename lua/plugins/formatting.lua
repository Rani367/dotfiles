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
      if vim.b[bufnr].large_file then return nil end
      return { timeout_ms = 3000, lsp_format = "fallback" }
    end,
    notify_on_error = true,
  },
  init = function()
