return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false, -- skip annoying "do you want to configure?" prompts
        library = { vim.env.VIMRUNTIME }, -- make lsp aware of nvim runtime for vim.* completions
      },
      completion = { callSnippet = "Replace" },
      telemetry = { enable = false },
      diagnostics = { globals = { "vim", "Snacks" } }, -- suppress undefined-global warnings
    },
  },
}
