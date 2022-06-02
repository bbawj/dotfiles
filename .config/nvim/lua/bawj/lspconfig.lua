local vim = vim
local uv = vim.loop
local nvim_lsp = require("lspconfig")
local util = require("lspconfig.util")
local servers = { "tsserver", "csharp_ls" }

-- Diagnostic settings
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = true,
})

local function get_node_modules(root_dir)
	-- util.find_node_modules_ancestor()
	-- local root_node = root_dir .. "/node_modules"
    local search_path = root_dir .. "/**2"
    local root_node = root_dir .. "/" .. vim.fn.finddir("node_modules", search_path)
	local stats = uv.fs_stat(root_node)
	if stats == nil then
		return nil
	else
		return root_node
	end
end

local default_node_modules = get_node_modules(vim.fn.getcwd())

-- Mappings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<space>d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

	if client.server_capabilities.document_highlight then
		vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
		vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
		vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
	end
	-- formatting
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
	-- use null-ls instead of tsserver
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, lsp in ipairs(servers) do
	local custom_cmd = {}

	if lsp == "tsserver" then
		custom_cmd = {
			"typescript-language-server",
			"--stdio",
			"--tsserver-path",
			"/home/bawj/.nvm/versions/node/v12.20.0/lib/node_modules/typescript/lib",
		}
	end

	if next(custom_cmd) == nil then
		nvim_lsp[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	else
		nvim_lsp[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = custom_cmd,
			on_new_config = function(new_config)
				new_config.cmd = custom_cmd
			end,
		})
	end
end

local ngls_location = ""

if default_node_modules ~= nil then
	ngls_location = default_node_modules .. "/@angular/language-server/index.js"
end

local ngls_cmd = {
	-- "ngserver",
	"node",
	ngls_location,
	"--stdio",
	"--tsProbeLocations",
	default_node_modules,
	-- "/home/bawj/.nvm/versions/node/v16.15.0/lib/node_modules",
	"--ngProbeLocations",
	default_node_modules,
	-- "/home/bawj/.nvm/versions/node/v16.15.0/lib/node_modules",
	"--includeCompletionsWithSnippetText",
	"--includeAutomaticOptionalChainCompletions",
}

nvim_lsp.angularls.setup({
	cmd = ngls_cmd,
	on_attach = on_attach,
	-- root_dir = util.root_pattern("angular.json"),
	on_new_config = function(new_config)
		new_config.cmd = ngls_cmd
	end,
})
