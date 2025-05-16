--------------------------------------------------------------------------------
-- ICONS
--------------------------------------------------------------------------------
require("nvim-web-devicons").setup()

--------------------------------------------------------------------------------
-- MASON & MASON-NVIM-DAP
--------------------------------------------------------------------------------
require("mason").setup({
	ui = {
		border = "rounded",
	},
})


vim.diagnostic.config({
  float = {
    border = "rounded",
    style = "minimal",
    source = "always", -- show source of diagnostic
    header = "",       -- remove "Diagnostics" header
    prefix = "",       -- no prefix (or set to "●" for icons)
  },
  virtual_text = true, -- optional: show inline diagnostics
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
--------------------------------------------------------------------------------
-- UTILITY FUNCTION: RENAME FILE + REFERENCES
--------------------------------------------------------------------------------
local function rename_file(old_name, new_name)
	-- OS-level rename
	vim.cmd(string.format("silent !mv %s %s", old_name, new_name))

	-- Open the new file
	vim.cmd(string.format("edit %s", new_name))

	-- Prepare LSP rename request (will rename references in code)
	local params = vim.lsp.util.make_position_params()
	params.newName = new_name

	vim.lsp.buf_request(0, "textDocument/rename", params, function(err, _, result)
		if err then
			vim.notify("Error renaming file: " .. err.message)
		elseif result then
			vim.lsp.util.apply_workspace_edit(result, "utf-8")
			vim.notify("File and references renamed!")
		end
	end)
end

--------------------------------------------------------------------------------
-- GLOBAL DIAGNOSTIC KEYMAPS (not per-server)
--------------------------------------------------------------------------------
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<cr>")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<cr>")
vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>")
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<cr>")

--------------------------------------------------------------------------------
-- LSP ATTACH AUTOCMD: PER-SERVER KEYMAPS & HIGHLIGHTING
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Set up buffer-local LSP keymaps/actions after server attaches",
	callback = function(event)
		local buf = event.buf
		local client_id = event.data.client_id
		local client = vim.lsp.get_client_by_id(client_id)

		-- Convenient wrapper for mapping
		local function map(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
		end

		-- Telescope-based workspace symbol search
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- Standard LSP keymaps
		map("K", vim.lsp.buf.hover, "Hover symbol details")
		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gD", vim.lsp.buf.declaration, "Go to declaration")
		map("gi", vim.lsp.buf.implementation, "Go to implementation")
		map("go", vim.lsp.buf.type_definition, "Go to type definition")
		map("gr", vim.lsp.buf.references, "Go to references")
		map("gs", vim.lsp.buf.signature_help, "Signature help")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		if client and client.name and client.name == "clangd" then
			map("<leader>ch", "<CMD>ClangdSwitchSourceHeader<CR>", "switch sour[c]e [h]eader")
		end

		-- Custom: Rename file + references
		vim.keymap.set("n", "<leader>rf", function()
			local old_name = vim.fn.expand("%") -- Current filename
			local new_name = vim.fn.input("New file name: ", old_name)
			if #new_name > 1 and new_name ~= old_name then
				rename_file(old_name, new_name)
			else
				vim.notify("Rename canceled or invalid new name.")
			end
		end, { buffer = buf, desc = "Rename file + references" })

		-- Highlight references on CursorHold (if supported)
		if client and client.supports_method("textDocument/documentHighlight") then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- Clear highlights if LSP detaches
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(e)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = e.buf })
				end,
			})
		end

		-- Optional: toggle inlay hints if server supports them
		if client and client.supports_method("textDocument/inlayHint") then
			map("<leader>th", function()
				vim.lsp.inlay_hint(buf, nil) -- toggles by default
			end, "Toggle Inlay Hints")
		end
	end,
})

--------------------------------------------------------------------------------
-- CAPABILITIES FOR LSP (nvim-cmp)
--------------------------------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

--------------------------------------------------------------------------------
-- FISH LSP (not installed via Mason by default)
--------------------------------------------------------------------------------
-- If you installed `fish-lsp` manually, you can keep this direct call:
require("lspconfig").fish_lsp.setup({
	settings = {
		fish = {
			-- Disables `■ alias used, prefer using functions instead  error on my fish lsp`
			disableDiagnosticRules = { 2002 },
		},
	},
	capabilities = capabilities,
})

--------------------------------------------------------------------------------
-- NAMED HANDLERS FOR MASON-LSPCONFIG
--------------------------------------------------------------------------------
local lspconfig = require("lspconfig")
local util = lspconfig.util

-- 1) Default handler (for servers you don't customize)
local function default_handler(server_name)
	lspconfig[server_name].setup({
		capabilities = capabilities,
	})
end

-- 2) Arduino
local function arduino_handler()
	lspconfig.arduino_language_server.setup({
		cmd = {
			"/home/cacarico/go/bin/arduino-language-server",
			"-cli",
			"/sbin/arduino-cli",
			"-cli-config",
			"/home/cacarico/.arduino15/arduino-cli.yaml",
			"-clangd",
			"/home/cacarico/.local/share/nvim/mason/bin/clangd",
			"-fqbn",
			"arduino:avr:nano",
		},
		capabilities = capabilities,
	})
end

-- 3) Clangd
local function clangd_handler()
	-- NOTE: Move this just for clangd buffers
	lspconfig.clangd.setup({
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern(
				"Makefile",
				"configure.ac",
				"configure.in",
				"config.h.in",
				"meson.build",
				"meson_options.txt",
				"build.ninja"
			)(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
				"lspconfig.util"
			).find_git_ancestor(fname)
		end,
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--fallback-style=llvm",
		},
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
		capabilities = capabilities,
	})
end

-- 4) Dockerls
local function dockerls_handler()
	lspconfig.dockerls.setup({
		settings = {
			docker = {
				languageserver = {
					formatter = {
						ignoreMultilineInstructions = true,
					},
				},
			},
		},
		capabilities = capabilities,
	})
end

-- 5) ElixirLS
local function elixirls_handler()
	lspconfig.elixirls.setup({
		cmd = { "/home/cacarico/.asdf/shims/elixir-ls" },
		filetypes = { "elixir", "eelixir", "heex", "surface" },
		root_dir = util.root_pattern("mix.exs", ".git"),
		settings = {
			elixirLS = {
				dialyzerEnabled = false,
				fetchDeps = false,
				enableTestLenses = false,
			},
		},
		capabilities = capabilities,
	})
end

-- 6) Helm LS
local function helm_ls_handler()
	lspconfig.helm_ls.setup({
		settings = {
			["helm-ls"] = {
				yamlls = {
					path = "yaml-language-server",
				},
			},
		},
		capabilities = capabilities,
	})
end

-- 7) Lua LS
local function lua_ls_handler()
	lspconfig.lua_ls.setup({
		on_init = function(lua_client)
			local path = lua_client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				return
			end

			lua_client.config.settings.Lua = vim.tbl_deep_extend("force", lua_client.config.settings.Lua, {
				-- runtime = {
				-- 	version = "Lua 5.4",
				-- 	path = { "?.lua", "?/init.lua" },
				-- },
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						-- fix "undefined field fs_stat"
						"${3rd}/luv/library",
						"/usr/share/lua/5.4/",
						"/home/cacarico/.luarocks/share/lua/5.4/",
					},
				},
			})
		end,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "hyprlua" },
				},
			},
		},
		capabilities = capabilities,
	})
end

-- 8) Pyright
local function pyright_handler()
	lspconfig.pyright.setup({
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = false,
					extraPaths = { "." },
				},
			},
		},
		capabilities = capabilities,
	})
end

-- 9) Terraform
local function terraformls_handler()
	lspconfig.terraformls.setup({
		filetypes = { "terraform", "terraform-vars", "tf" },
		root_dir = util.root_pattern(".terraform", ".git"),
		capabilities = capabilities,
	})
end

--------------------------------------------------------------------------------
-- MASON-SETUP
--------------------------------------------------------------------------------
local ensure_installed = {
	-- LSP servers:
	"arduino_language_server",
	"bashls",
	"clangd",
	"cmake",
	"docker_compose_language_service",
	"dockerls",
	"elixirls",
	"emmet_language_server",
	"gopls",
	"helm_ls",
	"jsonnet_ls",
	"lua_ls",
	"markdown_oxide",
	"pyright",
	"rust_analyzer",
	"sqls",
	"terraformls",
	"ts_ls",
	"vimls",
	"yamlls",
	"jsonls",

	-- Other tools (formatters, linters, debuggers):
	"cbfmt",
	"codelldb",
	"fixjson",
	"htmlbeautifier",
	"luacheck",
	"prettier",
	"prettierd",
	"stylelint",
	"stylua",
	"yamlfix",
}

require("mason-tool-installer").setup({
	ensure_installed = ensure_installed,
})

-- - WARNING fixjson unavailable: Command not found
-- - OK gofmt ready (go)
-- - WARNING goimports unavailable: Command not found
-- - WARNING golines unavailable: Command not found
-- - WARNING htmlbeautifier unavailable: Command not found
-- - WARNING isort unavailable: Command not found
-- - WARNING prettier unavailable: Command not found
-- - WARNING prettierd unavailable: Command not found
-- - OK stylelint ready (css)
-- - OK stylua ready (lua)
-- - WARNING yamlfix unavailable: Command not found
-- - WARNING yamllint unavailable: Unknown formatter. Formatter config missing or incomplete

require("mason-lspconfig").setup({
	-- ensure_installed = ensure_installed,
	handlers = {
		default_handler,
		arduino_language_server = arduino_handler,
		clangd = clangd_handler,
		dockerls = dockerls_handler,
		elixirls = elixirls_handler,
		helm_ls = helm_ls_handler,
		lua_ls = lua_ls_handler,
		pyright = pyright_handler,
		terraformls = terraformls_handler,
	},
})

--------------------------------------------------------------------------------
-- SNIPPETS
--------------------------------------------------------------------------------
local luasnip = require("luasnip")

vim.keymap.set("i", "<C-K>", function()
	luasnip.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-N>", function()
	luasnip.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-P>", function()
	luasnip.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, { silent = true })

--------------------------------------------------------------------------------
-- COMPLETION (nvim-cmp)
--------------------------------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(), -- Adds border to the completion popup
		documentation = cmp.config.window.bordered(), -- Adds border to the documentation popup
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-o>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "vim-dadbod-completion" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
})
