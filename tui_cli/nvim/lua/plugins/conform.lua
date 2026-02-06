return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = function()
			local sh = { "shfmt" }
			local biome = { "biome" }

			-- Define the mapping of languages to formatter names
			local formatters = {
				bash = sh,
				sh = sh,
				zsh = sh,
				lua = { "stylua" },
				go = { "goimports" },
				python = { "ruff_format" },
				javascript = biome,
				typescript = biome,
				javascriptreact = biome,
				typescriptreact = biome,
				json = biome,
				jsonc = biome,
				yaml = biome,
				html = biome,
				css = biome,
				less = biome,
				sass = biome,
			}

			return {
				formatters_by_ft = vim.tbl_extend("force", formatters, {
					markdown = { "injected" },
				}),

				formatters = {
					-- 1. Biome configuration
					biome = {
						args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
					}, -- <--- Make sure this comma exists!

					-- 2. Injected configuration
					injected = {
						options = {
							ignore_errors = false,
							lang_to_formatters = formatters,
						},
					},
				},
			}
		end,
	},
}
