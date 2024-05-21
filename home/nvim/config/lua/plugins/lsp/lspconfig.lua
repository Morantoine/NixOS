return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    local on_attach = function(client, bufnr)
      keymap.set("n", "<leader>ln", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { desc = "Lsp Rename", expr = true })
      keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Lsp CodeActions", noremap = true, silent = true })
      keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover-Over Documentation", noremap = true, silent = true })
      keymap.set("n", "<leader>lR", ":LspRestart<CR>", { desc = "Lsp Restart", noremap = true, silent = true })
      vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
    end

    -- enable autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- configure python server
    lspconfig["pylsp"].setup({
      -- filetypes = { "py", "sage" },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pylsp = {
          plugins = {
            black = {
              cache_config = true,
              enabled = true,
              line_length = 119,
            },
            flake8 = {
              enabled = true,
              maxLineLength = 119,
            },
            mypy = {
              enabled = true,
            },
            pycodestyle = {
              enabled = false,
            },
            pyflakes = {
              enabled = false,
            },
            ruff = {
              enabled = true,
              extendSelect = { "I" },
            },
            pyls_isort = { enabled = true },
          }
        }
      }
    })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        },
      },
    })

    -- configure rust server
    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      -- Server-specific settings. See `:help lspconfig-setup`
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          }
        },
      },
    })

    -- configure latex server
    lspconfig.texlab.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    --
    -- configure latex spellcheck server
    lspconfig.ltex.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        keymap.set("n", "<leader>ln", function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, { desc = "Lsp Rename", expr = true })
        keymap.set("n", "<leader>la", vim.lsp.buf.code_action,
          { desc = "Lsp CodeActions", noremap = true, silent = true })
        keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover-Over Documentation", noremap = true, silent = true })
        keymap.set("n", "<leader>lR", ":LspRestart<CR>", { desc = "Lsp Restart", noremap = true, silent = true })
        vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
        require("ltex_extra").setup({})
      end,
    })

    -- custom capabilities for clangd
    local capabilities_clang = cmp_nvim_lsp.default_capabilities()
    capabilities_clang.offsetEncoding = { "utf-16" }

    -- C server with annoying encoding
    lspconfig["clangd"].setup({
      capabilities = capabilities_clang,
      on_attach = on_attach,
    })
  end,
}
