-- nvim config entry point
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")

vim.lsp.enable({ "pyright", "clangd", "lua_ls" })
