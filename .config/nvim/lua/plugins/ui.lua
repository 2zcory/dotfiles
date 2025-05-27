return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>ut")
      return { mode = "cursor", max_lines = 3 }
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
  __         .__        __     _____     .___.__                                   
_/  |________|__| ____ |  | __/ ___ \  __| _/|__|____________  ____   ___  ______  
\   __\_  __ \  |/    \|  |/ / / ._\ \/ __ | |  \____ \_  __ \/  _ \  \  \/ /    \ 
 |  |  |  | \/  |   |  \    <  \_____/ /_/ | |  |  |_> >  | \(  <_> )  \   /   |  \
 |__|  |__|  |__|___|  /__|_ \_____\ \____ | |__|   __/|__|   \____/ /\ \_/|___|  /
                     \/     \/            \/    |__|                 \/         \/ 
          ]],
        },
      },
    },
  },
}
