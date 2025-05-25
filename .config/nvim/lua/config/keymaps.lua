-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

---@class KeymapOpts
---@field noremap? boolean
---@field silent? boolean
---@field expr? boolean
---@field nowait? boolean
---@field desc? string
---@field buffer? number|boolean
---@param opts KeymapOpts
local function keymap_opts(opts)
  return vim.tbl_extend("force", {
    noremap = true,
    silent = true,
  }, opts or {})
end

-- Tab

-- cmd
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Windows
map("n", "<leader>\\", "<cmd>vsplit<CR>", keymap_opts({ desc = "Windows - split window right" }))
map("n", "<M-Up>", "<cmd>resize +2<CR>", keymap_opts({ desc = "Alt + Down: Increase height" }))
map("n", "<M-Down>", "<cmd>resize -2<CR>", keymap_opts({ desc = "Alt + Down: Increase height" }))
map("n", "<M-Left>", "<cmd>vertical resize -4<CR>", keymap_opts({ desc = "Alt + Down: Increase height" }))
map("n", "<M-Right>", "<cmd>vertical resize +4<CR>", keymap_opts({ desc = "Alt + Down: Increase height" }))

-- Telescope
map(
  "n",
  "<leader>fw",
  "<cmd>Telescope live_grep<CR>",
  keymap_opts({ desc = "Telescope Live Grep - Search Words in Workspace" })
)

