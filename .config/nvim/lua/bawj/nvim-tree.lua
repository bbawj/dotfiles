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
		height = 30,
		hide_root_folder = false,
		side = "left",
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {
				-- user mappings go here
				{ key = "<2-RightMouse>", action = "" },
				{ key = "h", action = "close_node" },
				{ key = "cd", action = "cd" },
				{ key = { "l", "<CR>" }, action = "edit" },
			},
		},
	},
})
