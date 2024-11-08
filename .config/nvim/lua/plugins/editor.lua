return {
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      -- add keymaps
      {
        "<leader>nf",
        "<cmd>Neotree focus<CR>",
        {
          desc = "Neotree focus",
        },
      },
      { "<leader>fe", false },
      { "<leader>fE", false },
      {
        "<leader>ne",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>nE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>ne", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>nE", desc = "Explorer NeoTree (cwd)", remap = true },
    },
  },

  -- Window picker
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        prompt_message = "ウインドウを選択する。",
        hint = "floating-big-letter",
      })
    end,
  },
}
