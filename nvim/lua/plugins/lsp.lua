-- mason manages lsp server binaries
return {
  "mason-org/mason.nvim",
  cmd = "Mason",
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
  config = function(_, opts)
    require("mason").setup(opts)

    local ensure_installed = { "pyright", "clangd", "lua-language-server" }
    local mr = require("mason-registry")
    mr.refresh(function()
      for _, tool in ipairs(ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
