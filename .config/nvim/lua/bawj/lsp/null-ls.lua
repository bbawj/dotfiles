local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local sources = {
			--formatting.eslint_d
            formatting.prettierd,
            formatting.stylua
	}

local M = {}
M.setup = function(on_attach)
        null_ls.setup({
            -- debug = true,
            sources = sources,
            on_attach = on_attach,
        })
end

return M
