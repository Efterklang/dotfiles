return {
	"mason-org/mason.nvim",
	opts = {
		ensure_installed = {
			"shfmt",
			-- "nufmt", not support, need maunal install via `cargo install --git https://github.com/nushell/nufmt`
			"stylua",
			"goimports",
			"ruff",
			"biome",
		},
	},
}
