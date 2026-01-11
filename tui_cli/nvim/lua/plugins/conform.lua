return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = function()
      return {
        formatters_by_ft = {
          lua = { "stylua" },
          go = { "goimports" },
          python = { "ruff_format" },

          javascript = { "biome" },
          typescript = { "biome" },
          javascriptreact = { "biome" },
          typescriptreact = { "biome" },

          json = { "biome" },
          jsonc = { "biome" },
          yaml = { "biome" },
          html = { "biome" },

          css = { "biome" },
          less = { "biome" },
          sass = { "biome" },
        },
      }
    end,
  },
}
