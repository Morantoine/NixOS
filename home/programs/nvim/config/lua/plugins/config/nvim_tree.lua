local tree_status, tree = pcall(require, "nvim-tree")
if not tree_status then
	return
end

-- Recommended settings from nvim-tree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Change arrow color
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

tree.setup({
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},
	filters = { dotfiles = true },
})

-- auto-open file upon creation
local api = require("nvim-tree.api")

api.events.subscribe(api.events.Event.FileCreated, function(file)
	vim.cmd("edit " .. file.fname)
end)
