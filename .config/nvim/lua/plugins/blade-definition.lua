return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          filetypes = { "php", "blade" },
          settings = {
            intelephense = {
              files = {
                associations = { "*.php", "*.blade.php" }
              }
            }
          },
          keys = {
            { "gl", false },
            { "gk", false },
          }
        }
      }
    }
  },
  {
    "nvim-lua/plenary.nvim",
    event = "BufReadPre *.blade.php",
    config = function()
      local function extract_view_name(line)
        local patterns = {
          "@include%s*%(%s*[\"']([%w_%.%-/]+)[\"']%s*%)",
          "@extends%s*%(%s*[\"']([%w_%.%-/]+)[\"']%s*%)",
          "@component%s*%(%s*[\"']([%w_%.%-/]+)[\"']%s*%)",
        }

        for _, pattern in ipairs(patterns) do
          local view = line:match(pattern)
          if view then return view end
        end

        return nil
      end

      local function go_to_blade_view()
        local line = vim.api.nvim_get_current_line()
        local view_name = extract_view_name(line)
        if not view_name then
          vim.notify("No Blade view directive found on this line", vim.log.levels.INFO)
          return
        end

        local path = "resources/views/" .. view_name:gsub("%.", "/") .. ".blade.php"
        if vim.fn.filereadable(path) == 1 then
          vim.cmd("edit " .. path)
        else
          vim.notify("Blade view not found: " .. path, vim.log.levels.WARN)
        end
      end

      local function go_to_route()
        local line = vim.api.nvim_get_current_line()
        local route_name = line:match("route%s*%(%s*[\"']([%w%._%-]+)[\"']%s*%)")

        if not route_name then
          vim.notify("No route('...') pattern found in current line", vim.log.levels.INFO)
          return
        end

        local route_dir = "routes/web"
        local route_files = vim.fn.globpath(route_dir, "*.php", false, true)

        if vim.tbl_isempty(route_files) then
          vim.notify("No route files found in: " .. route_dir, vim.log.levels.ERROR)
          return
        end

        local search_pattern = "[\"']" .. route_name .. "[\"']"

        for _, file in ipairs(route_files) do
          local lines = vim.fn.readfile(file)
          for i, content in ipairs(lines) do
            if content:match(search_pattern) then
              vim.cmd("edit " .. file)
              vim.fn.cursor(i, 1)
              return
            end
          end
        end

        vim.notify("Route '" .. route_name .. "' not found in any files under " .. route_dir, vim.log.levels.WARN)
      end

      local function go_to_livewire()
        local line = vim.api.nvim_get_current_line()
        local component = line:match("@livewire%s*%(%s*[\"']([%w_%.%-]+)[\"']")
        if component then
          local path = "app/Http/Livewire/" .. component:gsub("%.", "/"):gsub("%-", "") .. ".php"
          if vim.fn.filereadable(path) == 1 then vim.cmd("edit " .. path)
          else vim.notify("Livewire component not found: " .. path, vim.log.levels.WARN) end
        else
          vim.notify("No @livewire directive found", vim.log.levels.INFO)
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "blade" },
        callback = function()
          vim.keymap.set("n", "gl", go_to_blade_view, { buffer = true, desc = "Go to included Blade file" })
          vim.keymap.set("n", "gk", go_to_route, { buffer = true, desc = "Go to route definition" })
        end,
      })
    end,
  },
}