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

  local main_count = 0
  for _, f in ipairs(all_files) do
    if has_main_function(f) then
      main_count = main_count + 1
      if main_count > 1 then break end
    end
  end

  -- multiple mains = independent files, compile only current
  local to_compile = main_count > 1 and { file } or all_files
  local escaped = {}
  for _, f in ipairs(to_compile) do
    table.insert(escaped, esc(f))
  end
  return escaped
end

local function get_run_command(ft, file)
  local handlers
  handlers = {
    python = function()
      local py = find_exe({ "python3", "python" })
      if not py then return nil, "python3 not found" end
      return py .. " " .. esc(file)
    end,

    cs = function()
      if not has("dotnet") then return nil, "dotnet not found" end
      local dir = vim.fn.fnamemodify(file, ":h")
      local csproj = vim.fn.glob(dir .. "/*.csproj", false, true)
      if #csproj > 0 then
        return "dotnet run --project " .. esc(csproj[1])
      end
      return "cd " .. esc(dir) .. " && dotnet run"
    end,

    c = function()
      local cc = find_exe({ "clang", "gcc" })
      if not cc then return nil, "C compiler not found" end
      local dir = vim.fn.fnamemodify(file, ":h")
      if vim.fn.filereadable(dir .. "/Makefile") == 1 or vim.fn.filereadable(dir .. "/makefile") == 1 then
        return "cd " .. esc(dir) .. " && make run 2>/dev/null || make && ./a.out"
      end
      local sources = get_dependent_sources(file, "c")
      local out = tmpfile("c_out")
      return cc .. " -std=c11 -Wall -Wextra -o " .. esc(out) .. " " .. table.concat(sources, " ") .. " && " .. esc(out)
    end,

    cpp = function()
      local cxx = find_exe({ "g++", "clang++", "c++" })
      if not cxx then return nil, "C++ compiler not found" end
      local dir = vim.fn.fnamemodify(file, ":h")
      if vim.fn.filereadable(dir .. "/Makefile") == 1 or vim.fn.filereadable(dir .. "/makefile") == 1 then
        return "cd " .. esc(dir) .. " && make run 2>/dev/null || make && ./a.out"
      end
      local sources = get_dependent_sources(file, "cpp")
      local out = tmpfile("cpp_out")
      return cxx .. " -std=c++17 -Wall -Wextra -o " .. esc(out) .. " " .. table.concat(sources, " ") .. " && " .. esc(out)
    end,

    lua = function()
      local lua = find_exe({ "luajit", "lua5.4", "lua5.3", "lua5.1", "lua" })
      if not lua then return nil, "lua not found" end
      return lua .. " " .. esc(file)
    end,

    javascript = function()
      local node = find_exe({ "node", "nodejs" })
      if not node then return nil, "node not found" end
      return node .. " " .. esc(file)
    end,

    typescript = function()
      if has("tsx") then return "tsx " .. esc(file) end
      if has("bun") then return "bun run " .. esc(file) end
      if has("npx") then return "npx --yes tsx " .. esc(file) end
      return nil, "tsx/bun/npx not found"
    end,

    typescriptreact = function() return handlers.typescript() end,

    sh = function() return "bash " .. esc(file) end,
    bash = function() return handlers.sh() end,

    zsh = function()
      if not has("zsh") then return nil, "zsh not found" end
      return "zsh " .. esc(file)
    end,

    go = function()
      if not has("go") then return nil, "go not found" end
