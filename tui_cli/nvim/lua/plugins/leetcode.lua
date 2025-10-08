local leet_arg = "leetcode.nvim"

return {
  "kawre/leetcode.nvim",
  lazy = leet_arg ~= vim.fn.argv(0, -1),
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  dependencies = {
    -- include a picker of your choice, see picker section for more details
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lang = "python",
    cn = { -- leetcode.cn
      enabled = true, ---@type boolean
      translator = false, ---@type boolean
      translate_problems = true, ---@type boolean
    },
    storage = {
      home = "/Users/gjx/Projects/code_draft/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    theme = {
      [""] = { fg = "#cdd6f4" },
      ["all_alt"] = { fg = "#585b70" },

      easy = { fg = "#a6e3a1" },
      medium = { fg = "#f9e2af" },
      hard = { fg = "#f38ba8" },

      easy_alt = { fg = "#4d7c0f" },
      medium_alt = { fg = "#854d0e" },
      hard_alt = { fg = "#9f1239" },

      ok = { fg = "#a6e3a1" },
      info = { fg = "#89b4fa" },
      hint = { fg = "#cba6f7" },
      error = { fg = "#f38ba8" },

      case_ok = { fg = "#a6e3a1", bg = "#1e1e2e", bold = true },
      case_err = { fg = "#f38ba8", bg = "#1e1e2e", bold = true },
      case_focus_ok = { bg = "#a6e3a1", fg = "#1e1e2e", bold = true },
      case_focus_err = { bg = "#f38ba8", fg = "#1e1e2e", bold = true },

      normal = { fg = "#cdd6f4" },
      alt = { fg = "#94e2d5" },

      code = { fg = "#f5c2e7", bg = "#1e1e2e" },
      example = { fg = "#cba6f7" },
      constraints = { fg = "#89b4fa" },
      header = { fg = "#f9e2af", bold = true },
      followup = { fg = "#a6e3a1", bold = true },

      indent = { fg = "#585b70" },
      link = { fg = "#89b4fa", underline = true },
      list = { fg = "#f9e2af" },
      ref = { fg = "#cba6f7" },
      su = { fg = "#a6e3a1" },

      calendar_0 = { fg = "#585b70" },
      calendar_10 = { fg = "#4d7c0f" },
      calendar_20 = { fg = "#65a30d" },
      calendar_30 = { fg = "#84cc16" },
      calendar_40 = { fg = "#a3e635" },
      calendar_50 = { fg = "#a6e3a1" },
      calendar_60 = { fg = "#b4f3b4" },
      calendar_70 = { fg = "#bbf7be" },
      calendar_80 = { fg = "#dcfce7" },
      calendar_90 = { fg = "#ecfdf5" },
      calendar_100 = { fg = "#f0fdf4" },
    },
  },
}
