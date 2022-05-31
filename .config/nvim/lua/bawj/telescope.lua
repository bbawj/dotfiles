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
            }
        }
	},
	-- other configuration values here
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")

local M = {}

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "/home/bawj/",
		hidden = true,
	})
end

return M
