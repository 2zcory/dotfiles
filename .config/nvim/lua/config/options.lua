-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.termguicolors = true
vim.g.lazyvim_check_order = false
vim.filetype.add({
  extension = {
    zsh = "zsh",
  },
  pattern = {
    ["%.zsh"] = "zsh",
    ["%.zshrc"] = "zsh",
  },
})
