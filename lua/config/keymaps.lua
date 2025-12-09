local map = vim.keymap.set

map("n", "<leader>s", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

map("n", "<leader>r", function()
  require("util.runner").run_current_file()
end, { desc = "Run current file" })

map("t", "<Esc>", function()
  require("util.runner").hide_terminal()
end, { desc = "Hide terminal" })

map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
map("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Grep" })
