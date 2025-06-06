local map = LazyVim.safe_keymap_set

-- go to line start/end
map("", "<A-Left>", "^", { noremap = true, silent = true })
map("", "<A-Right>", "$", { noremap = true, silent = true })
-- move line up/down
map("", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
map("", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
-- word move
map("", "<C-H>", "db", { noremap = true, silent = true })
map("", "<C-delete>", "dw", { noremap = true, silent = true })
map("", "<C-Left>", "b", { noremap = true, silent = true })
map("", "<C-Right>", "w", { noremap = true, silent = true })

map("", "<C-a>", "ggVG", { noremap = true, silent = true })
map("", "<C-c>", '"+yy', { noremap = true, silent = true })
map("", "<C-x>", '"+dd', { noremap = true, silent = true })
map("", "<C-v>", '"+p', { noremap = true, silent = true })
map("", "<C-s>", ":x<CR>", { noremap = true, silent = true })
map("", "<C-z>", ":undo<CR>", { noremap = true, silent = true })
map("v", "y", '"+y')
map("v", "d", '"+d')
map("n", "yy", '"+yy', { noremap = true, silent = true })
map("n", "dd", '"+dd', { noremap = true, silent = true })
map("n", "p", '"+p', { noremap = true, silent = true })
