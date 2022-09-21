local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		layout_strategy = "horizontal",
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
			-- other layout configuration here
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	-- other configuration values here
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")
vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files)
vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep)
vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers)
vim.keymap.set("n", "<leader>fs", require('telescope.builtin').git_status)
-- vim.keymap.set("n", "<leader>fh", require('bawj.telescope').search_dotfiles({ hidden = true }))
vim.keymap.set("n", "<leader>fs", require('telescope.builtin').git_status)
vim.keymap.set("n", "<leader>fd", require('telescope.builtin').diagnostics)
vim.keymap.set("n", "<leader>fr", require('telescope.builtin').lsp_references)

local M = {}

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "/home/bawj/",
		hidden = true,
	})
end

return M
