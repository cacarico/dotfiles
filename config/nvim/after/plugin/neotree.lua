-- Remove legacy commands
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- Mappings
vim.keymap.set("n", "<leader>tt", "<cmd>Neotree toggle<cr>", { desc = "[t]oogle Neo[t]ree" })
vim.keymap.set("n", "<leader>T", "<cmd>Neotree focus<cr>", { desc = "[t]oogle Neo[T]ree" })

local function getTelescopeOpts(state, path)
	return {
		cwd = path,
		search_dirs = { path },
		attach_mappings = function(prompt_bufnr)
			local actions = require("telescope.actions")
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local action_state = require("telescope.actions.state")
				local selection = action_state.get_selected_entry()
				local filename = selection.filename
				if filename == nil then
					filename = selection[1]
				end
				-- any way to open the file without triggering auto-close event of neo-tree?
				require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
			end)
			return true
		end,
	}
end

require("neo-tree").setup({

	close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
	default_component_configs = {
		diagnostics = {
			symbols = {
				hint = "󰌵",
				info = " ",
				warn = " ",
				error = " ",
			},
		},
	},

	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = false,
			hide_by_name = {
				--"node_modules"
				"__pycache__",
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				".deployment",
				".github",
				".git",
				".gitignore",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				--".DS_Store",
				--"thumbs.db"
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
			--               -- the current file is changed while the tree is open.
			leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- window like netrw would, regardless of window.position
		-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			position = "right",
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				-- ["D"] = "fuzzy_sorter_directory",
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
				["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["og"] = { "order_by_git_status", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
				["tf"] = "telescope_find",
				["tg"] = "telescope_grep",
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-n>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-p>"] = "move_cursor_up",
			},
		},

		commands = {
			telescope_find = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				require("telescope.builtin").find_files(getTelescopeOpts(state, path))
			end,
			telescope_grep = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
			end,
		},
		components = {
			harpoon_index = function(config, node, state)
				local Marked = require("harpoon.mark")
				local path = node:get_id()
				local succuss, index = pcall(Marked.get_index_of, path)
				if succuss and index and index > 0 then
					return {
						text = string.format("🔱%d", index),
						highlight = config.highlight or "NeoTreeDirectoryIcon",
					}
				else
					return {}
				end
			end,
		},
		renderers = {
			file = {
				{ "icon" },
				{ "name", use_git_status_colors = true },
				{ "harpoon_index" },
				{ "diagnostics" },
				-- { "git_status", highlight = "NeoTreeDimText" },
			},
		},
	},
	buffers = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
		group_empty_dirs = true,
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
	},
})
