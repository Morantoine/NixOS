return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "jvgrootveld/telescope-zoxide",
  },
  config = function()
    vim.treesitter.language.register('python', 'sage')
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local trouble = require("trouble.providers.telescope")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-t>"] = actions.select_tab,
            ["<C-q>"] = trouble.open_with_trouble,
          },
          n = {
            ["<C-t>"] = actions.select_tab,
          }
        },
        file_ignore_patterns = {
          "*.aux",
          "*.fls",
          "*.blg",
          "*.bcf",
          "*.bbl",
        }
      },
      pickers = {
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          theme = "dropdown",
          previewer = false,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
          },
        },
      },
      extensions = {
        file_browser = {
          auto_depth = true,
          display_stat = false,
          grouped = true,
          select_buffer = true,
        },
        frecency = {
          db_safe_mode = false,
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("zoxide")
    telescope.load_extension("file_browser")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffer List" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Nvim Help Tags" })
    keymap.set("n", "<leader>fn", "<cmd>Noice telescope<cr>", { desc = "Noice Notifications" })
    keymap.set("n", "<leader>fz", "<cmd>Telescope zoxide list<cr>", { desc = "Zoxide Dirs" })
    keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
    keymap.set("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      { desc = "Workspace Symbols" })
    keymap.set("n", "<leader>fp", "<cmd>Telescope possession list<cr>", { desc = "Session List" })
    keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<CR>", { desc = "File Explorer" })
    keymap.set("n", "<leader>fE", "<cmd>Telescope file_browser path=%:p:h<CR>",
      { desc = "File Explorer In Current File Dir" })
  end,
}
