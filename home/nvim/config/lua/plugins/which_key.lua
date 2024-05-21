return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    defaults = {
      ["<leader>f"] = { name = "file commands" },
      ["<leader>l"] = { name = "lsp commands" },
      ["<leader>b"] = { name = "buffer commands" },
      ["<leader>s"] = { name = "split commands" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end
}
