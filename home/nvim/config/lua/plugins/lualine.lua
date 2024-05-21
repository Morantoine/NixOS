return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
        section_separators = { left = '', right = '' },
        component_separators = '',
        theme = "catppuccin",
      },

      extensions = { "nvim-tree", "fugitive" },
    })
  end,
}
