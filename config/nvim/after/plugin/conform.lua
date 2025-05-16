require("conform").setup({
	-- format_on_save = {
	-- 	-- These options will be passed to conform.format()
	-- 	timeout_ms = 500,
	-- 	lsp_format = "fallback",
	-- },
	-- format_after_save = {
	-- 	lsp_format = "fallback",
	-- },
	formatters_by_ft = {
		css = { "stylelint" },
		cpp = { "clang-format" },
		fish = { "fish_indent" },
		go = { "gofmt", "goimports", "golines" },
		html = { "htmlbeautifier" },
		javascript = { "prettierd", "prettier" },
		json = { "fixjson" },
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettierd", "prettier" },
		yaml = { "yamllint", "yamlfix" },
		sql = {},
		markdown = { "cbfmt" },
	},
	stop_after_first = {
		javascript = true,
	},
	formatters = {
		yamlfix = {},
		sql = {},
	},
})

vim.keymap.set("n", "<leader>F", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, {
	desc = "[F]ormat buffer",
})
