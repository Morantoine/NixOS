return {
  "folke/noice.nvim",
  enabled = true,
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    local noice = require("noice")
    noice.setup({
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        lsp_doc_border = true
      },
      vim.keymap.set("c", "<S-Enter>", function()
        require("noice").redirect(vim.fn.getcmdline())
        end, { desc = "Redirect Cmdline" })
    })

    local notify = require("notify")
    notify.setup({
      background_colour = "#000000",
      stages = "fade"
    })
  end

}
