return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
	},
	dependencies = { "nvim-mini/mini.icons" },
	config = function()
		function _G.get_oil_winbar()
			local dir = require("oil").get_current_dir()
			if dir then
				return vim.fn.fnamemodify(dir, ":~")
			else
				return vim.api.nvim_buf_get_name(0)
			end
		end
		local detail = false

		require("oil").setup({
			default_file_explorer = true,
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
				["<C-k>"] = false,
				["<C-j>"] = false,
				["<C-r>"] = "actions.refresh",
				["<leader>y"] = "actions.yank_entry",
				["g."] = false,
				["zh"] = "actions.toggle_hidden",
				["H"] = "actions.parent",
				["L"] = "actions.select",
				["q"] = "actions.close",
				["gd"] = {
					desc = "Toggle file detail view",
					callback = function()
						detail = not detail
						if detail then
							require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
						else
							require("oil").set_columns({ "icon" })
						end
					end,
				},
			},
			win_options = {
				winbar = "%!v:lua.get_oil_winbar()",
			},
		})
	end,
}
