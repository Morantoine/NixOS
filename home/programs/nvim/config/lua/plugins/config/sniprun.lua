local sniprun_status, sniprun = pcall(require, "sniprun")
if not sniprun_status then
	return
end

sniprun.setup({
	selected_interpreters = { "Python3_fifo" },
	repl_enable = { "Python3_fifo" },
	display = { "Classic" },
})

-- vim.keymap.set('n', '<leader>sr', '<Plug>SnipRunOperator', {silent = true})
vim.keymap.set({ "n", "v" }, "<leader>sr", "<Plug>SnipRun", { silent = true })
