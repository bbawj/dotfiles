local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- OR use all default mappings
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'l', api.node.open.edit,          opts('Edit'))
end
require("nvim-tree").setup({
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		adaptive_size = false,
		width = 30,
    number = true,
    relativenumber = true,
		side = "left",
		signcolumn = "yes",
		},
    on_attach = my_on_attach,
})

local Remap = require("bawj.keymap")
local nnoremap = Remap.nnoremap
-- " NERDTree mappings
nnoremap("<C-n>", "<cmd> NvimTreeToggle<CR>")
nnoremap("<C-f>", "<cmd> NvimTreeFindFile<CR>")
nnoremap("<leader>r", "<cmd> NvimTreeRefresh<CR>")
