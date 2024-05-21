return {
  -- "Shatur/neovim-ayu",
  -- config = function()
  -- 	-- transparent background and gutter
  -- 	vim.cmd([[
  --      augroup user_colors
  --        autocmd!
  --        autocmd ColorScheme * highlight ErrorMsg guifg=#d95757 guibg=NONE
  --        autocmd ColorScheme * highlight LineNr guifg=fg guibg=NONE
  --        autocmd ColorScheme * highlight LspInlayHint gui=italic guifg=#626173 guibg=NONE
  --      augroup END
  --    ]])
  -- 	require("ayu").setup({
  -- 		overrides = {
  -- 			Normal = { bg = "None" },
  -- 			ColorColumn = { bg = "None" },
  -- 			SignColumn = { bg = "None" },
  -- 			Folded = { bg = "None" },
  -- 			FoldColumn = { bg = "None" },
  -- 			CursorColumn = { bg = "None" },
  -- 			WhichKeyFloat = { bg = "None" },
  -- 			VertSplit = { bg = "None" },
  -- 		},
  -- 	})
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end
}
