-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Tab

-- cmd
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Windows
map("n", "<leader>\\", "<cmd>vsplit<CR>", { desc = "Windows - split window right" })

-- Telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live Grep - Search Words in Workspace" })

