local gps = require("nvim-navic")
local function getFilePath()
	return vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
end
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "nord",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = false,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { getFilePath, { gps.get_location, cond = gps.is_available } },
		lualine_x = { "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "quickfix", "nvim-tree" },
})
