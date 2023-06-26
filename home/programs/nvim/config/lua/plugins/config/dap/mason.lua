local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

local ui_status, ui = pcall(require, "dapui")
if not ui_status then
	return
end

local dap_vt_status, dap_vt = pcall(require, "nvim-dap-virtual-text")
if not dap_vt_status then
	return
end

local mason_dap_status, mason_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_status then
	return
end

ui.setup()
dap_vt.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	ui.close()
end

mason_dap.setup({
	ensure_installed = { "python", "cpptools" },
	automatic_setup = true,
	handlers = {
		-- function(config)
		-- 	-- Keep original functionality
		-- 	mason_dap.default_setup(config)
		-- end,
	},
})
