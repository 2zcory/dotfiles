return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      overrides = {
        ["@lsp.type.method"] = { fg = "#ff9900" },
        ["@comment.lua"] = { fg = "#ffffff", bg = "#000000" },
      },
      transparent_mode = true,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
