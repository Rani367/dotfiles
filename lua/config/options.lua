local opt = vim.opt
local g = vim.g

opt.number = true
opt.signcolumn = "yes" -- prevents layout shift
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

opt.updatetime = 300 -- default 4000, affects CursorHold
opt.timeoutlen = 400

opt.undofile = true
opt.swapfile = false

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.clipboard = "unnamedplus"
opt.shortmess:append("I") -- suppress intro screen

opt.termguicolors = true
opt.cursorline = true
