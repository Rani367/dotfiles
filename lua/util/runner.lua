local M = {}

local function esc(path) return vim.fn.shellescape(path, 1) end
local function has(cmd) return vim.fn.executable(cmd) == 1 end
local function find_exe(candidates)
  for _, exe in ipairs(candidates) do
    if has(exe) then return exe end
  end
end
local _counter = 0
local function tmpfile(prefix, ext)
  _counter = _counter + 1
  local name = string.format("%s_%d_%d_%d", prefix, vim.fn.getpid(), vim.uv.hrtime(), _counter)
