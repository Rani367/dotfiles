return {
  "echasnovski/mini.nvim",
  lazy = false,
  config = function()
    require("mini.pairs").setup()
    require("mini.ai").setup()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()
  end,
}
