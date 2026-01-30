-- \22 is ctrl-v (visual block mode) as a literal character
local mode_map = {
  n = "-- NORMAL --", i = "-- INSERT --", v = "-- VISUAL --", V = "-- VISUAL LINE --", ["\22"] = "-- VISUAL BLOCK --",
  c = "-- COMMAND --", R = "-- REPLACE --", t = "-- TERMINAL --", s = "-- SELECT --", S = "-- SELECT LINE --",
}

-- global function for use in statusline expression
function _G.statusline_mode()
  local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
  return mode_map[mode] or mode
end
