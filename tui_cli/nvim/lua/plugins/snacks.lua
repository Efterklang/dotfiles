return {
	"folke/snacks.nvim",
	lazy = false,
	config = function()
		local header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⢀⠀⡀⠠⣐⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⡀⠁⠈⠁⠁⠘⠠⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⢀⠀⠑⠀⠀⠀⠀⠁⠠⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠀⢀⣀⢠⠠⡄⢤⠒⠔⠢⢒⠤⣂⢄⡰⢀⠀⡀⠀⠀⡀⠀⢀⣮⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠛⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠰⡠⢆⠊⠄⡉⠄⡡⢔⠠⢈⠼⣥⠂⡘⢰⢊⡔⢣⠔⠠⢉⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡄⠆⠓⡈⠄⠁⠡⢈⡐⠐⡈⠄⡉⡐⠠⠌⣀⠒⣌⠣⣎⡼⣥⢎⡓⡈⠌⡐⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠰⡐⠀⠐⠈⠀⠀⢀⢀⠂⠆⣐⢡⡌⢶⣰⣱⢳⣚⣴⢫⢶⣹⢎⡷⣹⢞⡰⢁⠂⠔⡁⠀⣤⡀⠀⠀⠀⠀⢀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠐⠀⠉⠀⠀⠀⠠⡐⢌⢂⠬⣜⣺⣥⢷⣻⡟⣶⢯⣟⣳⣞⣯⢳⣏⡟⣾⢳⢯⠰⡁⠌⡐⠀⠀⠊⠁⠀⠀⠀⢀⠂⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡐⠬⠑⣌⢺⣼⢻⣭⢷⣯⣟⣷⣻⣽⣻⡞⣷⣻⢞⣯⢾⡝⣮⢟⢢⠓⠠⠌⠠⠁⠀⠀⠀⠀⠀⢀⠂⢌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⢀⠢⠐⡡⢜⡳⣞⣟⣮⣟⣾⣻⣾⢿⣾⣟⣾⣷⣻⢧⣻⢟⣮⢷⡹⣾⢉⠦⢉⡐⢈⠁⠀⠀⠀⠀⠀⢀⠂⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠄⠀⠀⢂⠈⠤⢁⢎⣱⢾⣹⣞⡽⡾⣽⢾⣿⣽⣿⣳⣿⣟⣾⢯⣛⣾⣻⠼⣧⡛⢦⠩⠐⡠⠐⠀⠀⠁⠀⠀⣠⣆⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠈⠌⡐⢎⣼⢣⡟⣶⢯⣻⣝⣯⢿⣻⣾⢿⣽⣷⣻⣭⢿⡽⣺⢵⣻⠜⡱⠊⠄⢡⠀⠃⠀⠀⠀⠀⠠⠐⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠁⠎⢠⡙⡼⣧⢯⡽⣯⣻⢗⡾⣭⣟⣯⣟⣯⢷⣞⡷⣫⣟⡼⢏⡳⠌⠊⡅⢈⠔⠀⠀⠀⠀⠀⡐⠈⠄⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠊⢄⠣⣜⡳⣝⢮⡗⣯⢳⣯⡟⣷⣫⢾⡽⣞⣟⡾⣵⠛⣎⠱⡉⠐⠣⠁⠄⠣⠀⠀⠀⠀⢤⡁⠄⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠌⠌⡠⢓⢼⡹⣎⡟⣞⢷⣫⢞⡽⣣⢟⢭⡛⠵⡊⠖⠣⢉⡄⢂⠐⠉⠀⠀⠈⠀⢀⠠⢈⢒⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠌⡰⠀⡏⣜⡳⣝⡞⣩⠚⡬⢉⢖⠡⣎⢂⢉⠰⢀⠊⠄⡡⠀⠀⠀⢠⠀⢆⠠⠁⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢘⠁⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⡐⠡⢘⠤⡙⠴⡘⡤⢋⠐⠠⡌⢠⠉⠄⡂⢁⠢⢈⠘⣁⢐⠠⢑⠢⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠁⠢⠙⡈⠇⡳⢜⡠⢃⠂⠤⠁⣌⡐⡠⢅⠲⢊⠘⠢⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠱⠈⢁⠋⠈⠃⠀⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]

		---@diagnostic disable: missing-fields
		require("snacks").setup({
			notifier = {},
			picker = {
				matcher = { frecency = true, cwd_bonus = true, history_bonus = true },
				formatters = { icon_width = 5 },
			},
			dashboard = {
				preset = {
					keys = {
						{ icon = "󰈞 ", key = "f", desc = "Find files", action = ":lua Snacks.picker.smart()" },
						{ icon = " ", key = "o", desc = "Find history", action = "lua Snacks.picker.recent()" },
						{ icon = "󰑑 ", key = "g", desc = "Grep", action = ":lua Snacks.picker.grep()" },
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
						},
						{
							icon = " ",
							key = "d",
							desc = "Find dotfiles",
							action = ":lua Snacks.picker.files({ cwd = '~/Projects/dotfiles' })",
						},
						{ icon = " ", key = "o", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
						{
							icon = "󰒲 ",
							key = "l",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = "",
							key = "x",
							desc = "Lazy Extra",
							action = ":LazyExtras",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							icon = " ",
							key = "M",
							desc = "Mason",
							action = ":Mason",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
					header = header,
				},
				sections = {
					{ section = "header" },
					{ section = "keys" },
				},
			},
			terminal = {
				enabled = true,
			},
			image = {
				enabled = false,
				doc = { enabled = true, inline = false, float = true, max_width = 80, max_height = 20 },
			},
			indent = {
				enabled = false,
				indent = { enabled = false },
				animate = { duration = { step = 10, duration = 100 } },
				scope = { enabled = true, char = "┊", underline = false, only_current = true, priority = 1000 },
			},
			styles = {
				snacks_image = {
					border = "rounded",
					backdrop = false,
				},
			},
		})

		local map = function(key, func, desc)
			vim.keymap.set("n", key, func, { desc = desc })
		end

		local map_all_mode = function(key, func, desc)
			vim.keymap.set("", key, func, { desc = desc })
		end

		map_all_mode("<D-p>", Snacks.picker.smart, "Smart find file")
		map_all_mode("<C-p>", Snacks.picker.smart, "Smart find file")
		map("<leader>tt", Snacks.terminal.toggle, "Toggle Integrated Terminal")
		map("<leader>ff", Snacks.picker.smart, "Smart find file")
		map("<leader>fr", Snacks.picker.recent, "Find recent file")
		map("<leader>fw", Snacks.picker.grep, "Find content")
		map("<leader>fh", function()
			Snacks.picker.help({ layout = "dropdown" })
		end, "Find in help")
		map("<leader>fk", function()
			Snacks.picker.keymaps({ layout = "dropdown" })
		end, "Find keymap")
		map("<leader>fm", Snacks.picker.marks, "Find mark")
		map("<leader>fn", function()
			Snacks.picker.notifications({ layout = "dropdown" })
		end, "Find notification")
		map("grr", Snacks.picker.lsp_references, "Find lsp references")
		map("<leader>fS", Snacks.picker.lsp_workspace_symbols, "Find workspace symbol")
		map("<leader>fs", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ bufnr = bufnr })

			local function has_lsp_symbols()
				for _, client in ipairs(clients) do
					if client.server_capabilities.documentSymbolProvider then
						return true
					end
				end
				return false
			end

			if has_lsp_symbols() then
				Snacks.picker.lsp_symbols({
					tree = true,
				})
			else
				Snacks.picker.treesitter()
			end
		end, "Find symbol in current buffer")
		map("<leader>fd", Snacks.picker.diagnostics_buffer, "Find diagnostic in current buffer")
		map("<leader>fH", Snacks.picker.highlights, "Find highlight")
		map("<leader>f/", Snacks.picker.search_history, "Find search history")
		map("<leader>fj", Snacks.picker.jumps, "Find jump")
		-- other snacks features
		map("<leader>bc", Snacks.bufdelete.delete, "Delete buffers")
		map("<leader>bC", Snacks.bufdelete.other, "Delete other buffers")
		map("<leader>gg", function()
			Snacks.lazygit({ cwd = Snacks.git.get_root() })
		end, "Open lazygit")
		map("<leader>n", Snacks.notifier.show_history, "Notification history")
	end,
}
