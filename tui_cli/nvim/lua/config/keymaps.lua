local map = LazyVim.safe_keymap_set

map("", "<A-Left>", "^", { noremap = true, silent = true })
map("", "<A-Right>", "$", { noremap = true, silent = true })

map("", "<C-a>", "ggVG", { noremap = true, silent = true })
map("", "<C-c>", "\"+yy", { noremap = true, silent = true })
map("", "<C-x>", "\"+dd", { noremap = true, silent = true })
map("", "<C-v>", "\"+p", { noremap = true, silent = true })
map("", "<C-s>", ":x<CR>", { noremap = true, silent = true })
