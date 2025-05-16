require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"javascript",
		"typescript",
		"c",
		"lua",
		"rust",
		"go",
		"jsonnet",
		"bash",
		"fish",
		"python",
		"terraform",
		"markdown",
		"markdown_inline",
		"vim",
		"regex",
		"yaml",
		"helm",
		"luadoc",
	},

	sync_install = true,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- enable treesitter folding for go files
-- vim.cmd("autocmd filetype go setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()")

-- enable syntax highlighting for go using the go.nvim plugin
-- vim.g.go_highlight_types = 1
-- vim.g.go_highlight_fields = 1
-- vim.g.go_highlight_functions = 1
-- vim.g.go_highlight_function_calls = 1
-- vim.g.go_highlight_operators = 1

-- vim.g.go_highlight_build_constraints = 1
-- vim.g.go_highlight_generate_tags = 1

require("treesitter-context").setup({
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	multiwindow = false, -- Enable multiwindow support.
	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 1, -- Maximum number of lines to show for a single context
	trim_scope = "inner", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
	zindex = 10, -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
})
