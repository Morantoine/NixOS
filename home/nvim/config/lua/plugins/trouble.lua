return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    local keymap = vim.keymap -- for conciseness
    local trouble = require("trouble.providers.telescope")
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
      },
    })

    keymap.set("n", "<leader>lD", function()
      require("trouble").open("workspace_diagnostics")
    end, { desc = "Workspace Diagnostics" })
    keymap.set("n", "<leader>ld", function()
      require("trouble").open("document_diagnostics")
    end, { desc = "Document Diagnostics" })
    keymap.set("n", "<leader>lx", function()
      require("trouble").open("lsp_definitions")
    end, { desc = "Lsp Definitions" })
    keymap.set("n", "<leader>lt", function()
      require("trouble").open("lsp_type_definitions")
    end, { desc = "Lsp Type Definitions" })
    keymap.set("n", "<leader>li", function()
      require("trouble").open("lsp_implementations")
    end, { desc = "Lsp Implementations" })
    keymap.set("n", "<leader>lr", function()
      require("trouble").open("lsp_references")
    end, { desc = "Lsp References" })
  end,
}
