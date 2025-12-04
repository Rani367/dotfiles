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
opt.spell = false
opt.synmaxcol = 240 -- perf: skip highlighting past this column

opt.laststatus = 2
opt.showmode = false
opt.cmdheight = 0

local mode_map = {
  n = "-- NORMAL --", i = "-- INSERT --", v = "-- VISUAL --", V = "-- VISUAL LINE --", ["\22"] = "-- VISUAL BLOCK --",
  c = "-- COMMAND --", R = "-- REPLACE --", t = "-- TERMINAL --", s = "-- SELECT --", S = "-- SELECT LINE --",
}
function _G.statusline_mode()
  local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
  return mode_map[mode] or mode
end
opt.statusline = " %{v:lua.statusline_mode()} │ %f %m%=%l:%c %p%% "

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.completeopt = { "menu", "menuone", "noselect" }
