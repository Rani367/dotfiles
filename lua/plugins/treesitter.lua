return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    require("nvim-treesitter").install({
      "lua", "vim", "vimdoc", "query",
      "python", "c", "c_sharp", "cpp",
