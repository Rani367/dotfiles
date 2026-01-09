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
      "foldcolumn", "foldexpr", "foldlevel", "foldmethod",
      "foldminlines", "foldnestmax", "foldtext",
      "list", "modifiable", "previewwindow", "readonly",
      "scrollbind", "shiftwidth", "spell", "tabstop",
      "winfixheight", "winfixwidth", "wrap",
    },
  },
  config = function(_, opts)
    local resession = require("resession")
    resession.setup(opts)

    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = vim.api.nvim_create_augroup("resession_autosave", { clear = true }),
      callback = function()
        resession.save(vim.fn.getcwd(), { notify = false })
      end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      nested = true,
      group = vim.api.nvim_create_augroup("resession_autoload", { clear = true }),
      callback = function()
        if vim.fn.argc() == 0 then
          vim.schedule(function()
            resession.load(vim.fn.getcwd(), { silence_errors = true })
          end)
        end
      end,
    })
  end,
}
