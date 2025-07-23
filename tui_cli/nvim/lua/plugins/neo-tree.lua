return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    config = function()
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["<cr>"] = "open",
                    ["P"] = { "toggle_preview", config = { use_float = true } },
                    ["l"] = "focus_preview",
                },
            },
            filesystem = {
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                },
            },
        })
    end,
}
