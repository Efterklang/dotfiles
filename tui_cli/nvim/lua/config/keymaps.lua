-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("", "<A-Left>", "^", { noremap = true, silent = true })
map("", "<A-Right>", "$", { noremap = true, silent = true })
