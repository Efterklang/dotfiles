return {
  "stevearc/oil.nvim",
  lazy = false,
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
  dependencies = { "nvim-mini/mini.icons" },
  config = function()
    require("config.oil")
  end,
}
