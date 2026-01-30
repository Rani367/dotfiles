local opt = vim.opt
local g = vim.g

opt.number = true
opt.signcolumn = "yes" -- prevents layout shift
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

opt.updatetime = 300 -- default 4000, affects CursorHold
opt.timeoutlen = 400

-- persistent undo across sessions, swap is just overhead for local editing
opt.undofile = true
opt.swapfile = false

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

-- 8 lines of context when scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.clipboard = "unnamedplus"
opt.shortmess:append("I") -- suppress intro screen

opt.termguicolors = true
opt.cursorline = true
opt.synmaxcol = 240 -- perf: skip highlighting past this column
opt.winborder = "rounded"
opt.fillchars = { eob = " " } -- hide ~ on empty lines

opt.laststatus = 2
opt.showmode = false
opt.cmdheight = 0

require("util.statusline")
opt.statusline = " %{v:lua.statusline_mode()} │ %f %m%=%l:%c %p%% "

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

-- disable remote providers, not using any plugins that need them
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python3_provider = 0

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { source = true },
})

