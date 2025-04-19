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
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- bật blame trực tiếp
      current_line_blame_opts = {
        delay = 200, -- độ trễ (ms)
        virt_text_pos = "eol", -- vị trí: 'eol', 'overlay', hoặc 'right_align'
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit: file history" },
    },
  },
}
