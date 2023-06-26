local undotree_status, undotree = pcall(require, "undotree")
if not undotree_status then
	return
end

undotree.setup({
	float_diff = true, -- using float window previews diff, set this `true` will disable layout option
	layout = "left_bottom", -- "left_bottom", "left_left_bottom"
	ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt" },
	window = {
		winblend = 0,
	},
	keymaps = {
		["j"] = "move_next",
		["k"] = "move_prev",
		["J"] = "move_change_next",
		["K"] = "move_change_prev",
		["<cr>"] = "action_enter",
		["p"] = "enter_diffbuf",
		["q"] = "quit",
	},
})

-- Custom vim keymaps
vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
