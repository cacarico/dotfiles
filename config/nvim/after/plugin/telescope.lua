local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")

require("telescope").setup({
	defaults = {
		sorting_strategy = "descending",
		mappings = {
			i = {
				["<C-h>"] = "which_key",
				["<C-o>"] = actions.select_default,
				["<C-v>"] = actions.select_vertical,
				["<C-s>"] = actions.select_horizontal,
				["<C-t>"] = trouble.open,
			},
			n = {
				["<C-t>"] = trouble.open,
			},
		},
	},
})

-- mappings
vim.keymap.del("n", "<leader>f")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope fzf all files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope search buffers" })
vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Telescope search marks" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope Help Tags" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope fzf all keymaps" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope fzf git files" })
vim.keymap.set("n", "<leader>fd", builtin.current_buffer_fuzzy_find, { desc = "Telescope fzf current buffer" })
