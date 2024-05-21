return {
  "jedrzejboczar/possession.nvim",
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local possession = require("possession")
    possession.setup({
      autosave = {
        current = true
      },
    })
  end,
}
