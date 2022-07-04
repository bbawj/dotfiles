_G.__luacache_config = {
	chunks = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_chunks",
	},
	modpaths = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
	},
}
require("impatient")
require("bawj.lsp")
require("bawj.cmp")
require("bawj.treesitter")
require("bawj.telescope")
require("bawj.trouble")
require("bawj.comment")
require("bawj.lualine")
require("bawj.nvim-tree")
require("bawj.gitsigns")
require("bawj.blankline")
require("bawj.bufferline")
require("bawj.nvim-gps")
require("bawj.luasnips")
require("bawj.autopairs")
require("bawj.transparent")
require("bawj.dap")
