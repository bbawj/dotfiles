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
dap.adapters.python = {
  type = 'executable';
  command = '/home/bawj/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python3'
      end
    end;
  },
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
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/home/bawj/.local/share/nvim/mason/bin/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    cargo = {
      args = {"run", "--", "script"}
    },
    program = vim.fn.getcwd() .. "/target/debug/rclox",
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {"script"}
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
