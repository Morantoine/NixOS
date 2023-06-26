local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	return
end

lualine.setup({
	extensions = { "fugitive", "nvim-tree" },
	sections = {
		-- remove Tmux :(
		lualine_x = { "encoding", "filetype" },
		-- show session
	},
})

options = { theme = "dracula" }
