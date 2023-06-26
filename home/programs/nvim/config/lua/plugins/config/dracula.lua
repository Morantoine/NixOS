-- Set colorscheme

local dracula_status, dracula = pcall(require, "dracula")
if not dracula_status then
	return
end

dracula.setup({
	transparent_bg = true,
})

vim.cmd([[colorscheme dracula]])
-- override default ugly float color
vim.cmd([[highlight! link NormalFloat Normal]])
vim.api.nvim_set_hl(0, "debugPC", { link = "Normal" })
