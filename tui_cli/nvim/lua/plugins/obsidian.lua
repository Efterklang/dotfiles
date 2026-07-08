return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false, -- this will be removed in 4.0.0
		workspaces = {
			{
				name = "Diary",
				path = "~/OneDrive/Documents/diary",
			},
			{
				name = "Post",
				path = "~/OneDrive/Documents/posts",
			},
		},
	},
}
