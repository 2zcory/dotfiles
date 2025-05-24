return {
  {
    "stevearc/conform.nvim",
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = function(_, opts)
      -- Define your formatters
      table.insert(opts.formatters_by_ft, {
        lua = { "stylua" },

        typescript = { "prettier", stop_after_first = true },
        javascript = { "prettier", stop_after_first = true },

        zsh = { "shfmt" },
        sh = { "shfmt" },
        
        php = { "pint", "php_cs_fixer" },
        -- blade = { "blade-formatter", "rustywind" },
        blade = { "blade-formatter", "rustywind" },
      })

      return opts
    end,
  },
}
