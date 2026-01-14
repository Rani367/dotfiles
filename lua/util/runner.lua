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
  if ext then name = name .. "." .. ext end
  return (os.getenv("TMPDIR") or "/tmp") .. "/" .. name
end

local TERM_ID = "file_runner"

local function has_main_function(filepath)
  local f = io.open(filepath, "r")
  if not f then return false end
  local content = f:read("*a")
  f:close()
  -- %f[%w] = word boundary, catches int/void main(...) variants
  return content:match("%f[%w]main%s*%(") ~= nil
end

local function get_dependent_sources(file, extension)
  local dir = vim.fn.fnamemodify(file, ":h")
  local all_files = vim.fn.glob(dir .. "/*." .. extension, false, true)

