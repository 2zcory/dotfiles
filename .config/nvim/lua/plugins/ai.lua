return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("chatgpt").setup({})
    end,
    dependencies = {
      "MunifTanjim/nui.nvim", -- UI component Library for nvim
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim",
    },
  },
}
