local dap = require("dap")
local adapters_path = "/home/bawj/.config/nvim/"
dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { adapters_path .. "vscode-firefox-debug/dist/adapter.bundle.js" },
}
dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = { adapters_path .. "vscode-chrome-debug/out/src/chromeDebug.js" },
}
dap.adapters.coreclr = {
	type = "executable",
	command = "/usr/local/netcoredbg",
	args = { "--interpreter=vscode", "--launch-profile=Scoot.IBE.Api" },
}
dap.configurations.cs = {
	{
		type = "coreclr",
		name = "launch - netcoredbg",
		request = "launch",
		program = vim.fn.getcwd() .. "/ibe-api/Scoot.IBE.Api/bin/Debug/netcoreapp3.1/Scoot.IBE.Api.dll",
		-- program = function()
		-- 	return vim.ui.input({ prompt = "Path to DLL: " }, function(input)
		-- 		local path = vim.fn.getcwd() .. "/ibe-api/Scoot.IBE.Api/bin/Debug/netcoreapp3.1/" .. input
		-- 		print("test")
		-- 		print(path)
		-- 		return path
		-- 	end)
		-- end,
	},
}
-- dap.configurations.typescript = {
-- 	{
-- 		name = "Debug with Firefox",
-- 		type = "firefox",
-- 		request = "launch",
-- 		reAttach = true,
-- 		url = "http://localhost:3000",
-- 		webRoot = "${workspaceFolder}/ibe-web",
-- 		firefoxExecutable = "/usr/bin/firefox",
-- 	},
-- }
dap.configurations.typescript = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}
dap.configurations.javascriptreact = { -- change this to javascript if needed
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}
-- Keybinds
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>dc", "<cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>di", "<cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>do", "<cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>dO", "<cmd>lua require'dap'.step_out()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>dj", "<cmd>lua require'dap'.down()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>dk", "<cmd>lua require'dap'.up()<CR>", opts)

-- DAP UI
require("dapui").setup()
vim.api.nvim_set_keymap("n", "<space>dt", "<cmd>lua require'dapui'.toggle()<CR>", opts)
