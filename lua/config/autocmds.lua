local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- restore cursor to last edit position
autocmd("BufReadPost", {
  group = augroup("last_position", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = { "help", "lspinfo", "man", "qf", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd("FileType", {
  group = augroup("filetype_indent", { clear = true }),
  pattern = { "python", "rust" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

autocmd("TermOpen", {
  group = augroup("terminal_settings", { clear = true }),
  callback = function()
    vim.opt_local.spell = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- deferred: wait for session restore before opening picker
autocmd("VimEnter", {
  group = augroup("auto_file_picker", { clear = true }),
  callback = function()
    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        local has_real_buffer = false
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= "" then
            has_real_buffer = true
            break
          end
        end
        if not has_real_buffer then
          Snacks.picker.files()
        end
      end, 0)
    end
  end,
})

-- only show relative numbers in active window (avoids full-screen redraws)
local relnum_group = augroup("relative_number_toggle", { clear = true })
autocmd({ "WinEnter", "BufEnter", "FocusGained", "InsertLeave" }, {
  group = relnum_group,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = true
    end
  end,
})
