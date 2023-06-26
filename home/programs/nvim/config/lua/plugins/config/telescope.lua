local telescope_status, telescope = pcall(require, "telescope")
if not telescope_status then
	return
end

local lens_status, lens = pcall(require, "session-lens")
if not lens_status then
	return
end

local sessions_status, sessions = pcall(require, "auto-session")
if not sessions_status then
	return
end

local builtin = require("telescope.builtin")
require("telescope").load_extension("fzf")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
-- vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>ss", lens.search_session, {})
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", {})

lens.setup({
	-- theme_conf = { border = false },
	theme_conf = { winblend = 0 },
})

sessions.setup({
	-- don't create a session automatically
	auto_session_create_enabled = false,
})
