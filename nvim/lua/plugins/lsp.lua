return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall" },
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync" },
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = { "pyright", "clangd", "lua-language-server" },
    },
  },
}
