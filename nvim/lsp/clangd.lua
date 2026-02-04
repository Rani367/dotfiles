return {
  cmd = {
    "clangd",
    "--background-index", -- index project in background for faster goto-def
    "--clang-tidy", -- enable clang-tidy diagnostics
    "--header-insertion=iwyu", -- auto-insert headers following include-what-you-use
    "--completion-style=detailed", -- show full function signatures in completions
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
}
