return {
  "Luxed/ayu-vim",
  config = function()
    -- transparent background and gutter
    vim.cmd([[
      augroup user_colors
        autocmd!
        autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
        autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
        autocmd ColorScheme * highlight ErrorMsg guifg=#d95757 guibg=NONE
      augroup END
    ]])
    -- set the colorscheme
    vim.cmd([[
      set background=dark
      let g:ayucolor="dark"
      colorscheme ayu
    ]])
  end,
}
