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
