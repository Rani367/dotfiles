-- syntax highlighting and text objects via tree-sitter
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = function()
    require("nvim-treesitter").install({
      "lua", "vim", "vimdoc", "query",
      "python", "c", "c_sharp", "cpp",
      "json", "yaml", "toml", "markdown", "markdown_inline",
      "bash", "gitignore", "gitcommit", "diff",
    })
  end,
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
  end,
}
