local vim = vim
local uv = vim.loop
local nvim_lsp = require("lspconfig")
local util = require("lspconfig.util")
local servers = {
	"eslint",
	"emmet_ls",
	"angularls",
	"tsserver",
	"csharp_ls",
	"html",
	"cssls",
	"lua_ls",
	"pyright",
	"gopls",
	"clangd",
  "rust_analyzer",
  "tsserver",
  "kotlin_language_server",
	"jdtls",
	"ocamllsp",
}
require("mason").setup()

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
local buf_command = function(bufnr, name, fn, opts)
	vim.api.nvim_buf_create_user_command(bufnr, name, fn, opts or {})
end
-- Mappings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    -- filter = function(client)
    -- 	-- apply whatever logic you want (in this example, we'll only use null-ls)
    -- 	return client.name == "efm"
    -- end,
    bufnr = bufnr,
  })
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  local buf_opts = { noremap = true, silent = true, buffer = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, buf_opts)
  vim.keymap.set("n", "<space>h", vim.lsp.buf.hover, buf_opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, buf_opts)
  vim.keymap.set({ "n", "i" }, "<M-k>", vim.lsp.buf.signature_help, buf_opts)
  vim.keymap.set("n", "<space>gd", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, buf_opts)
  vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, buf_opts)
  vim.keymap.set("v", "<space>f", vim.lsp.buf.format, buf_opts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, buf_opts)

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
        lsp_formatting(bufnr)
      end,
    })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require("bawj.lsp.null-ls").setup(on_attach)

for _, lsp in ipairs(servers) do
	local custom_cmd = {}

	-- if lsp == "tsserver" then
	-- 	custom_cmd = {
	-- 		"typescript-language-server",
	-- 		"--stdio",
	-- 		"--tsserver-path",
	-- 		"/home/bawj/.nvm/versions/node/v12.20.0/lib/node_modules/typescript/lib",
	-- 	}
	-- end

	if lsp == "emmet_ls" then
		nvim_lsp[lsp].setup({
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
		})
  elseif lsp == "rust_analyzer" then
		nvim_lsp[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
        },
      },
		})
	elseif next(custom_cmd) == nil then
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

-- require "lspconfig".efm.setup {
--     init_options = {documentFormatting = true},
--     settings = {
--         rootMarkers = {".git/"},
--         languages = {
--             c = {
--                 uncrustify
--             }
--         }
--     }
-- }
local ngls_location = ""

if default_node_modules ~= nil then
	ngls_location = default_node_modules .. "/@angular/language-server/index.js"
end
