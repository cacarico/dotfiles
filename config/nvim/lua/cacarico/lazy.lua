local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	ui = {
		border = "rounded",
	},
	-- -----------------------------------------------------
	-- UI
	-- -----------------------------------------------------
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
	},
	"ThePrimeagen/harpoon",
	"akinsho/bufferline.nvim",
	-- "easymotion/vim-easymotion",
	-- "echasnovski/mini.nvim",
	"folke/which-key.nvim",
	"folke/todo-comments.nvim",
	"mbbill/undotree",
	"mhinz/vim-startify",
	"nathom/tmux.nvim",
	"nvim-telescope/telescope.nvim",
	"stevearc/dressing.nvim",
	"stevearc/oil.nvim",
	"MeanderingProgrammer/render-markdown.nvim",
	"3rd/image.nvim",
	"tpope/vim-rhubarb",
	-- "github/copilot.vim",

	-- -----------------------------------------------------
	--  "CODE"
	-- -----------------------------------------------------
	-- Git integration to show git signs on buffer
	"lewis6991/gitsigns.nvim",
	-- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists
  {
    "folke/trouble.nvim",
  cmd = "Trouble"

  },
	-- Automatically comments with gc
	"tpope/vim-commentary",
	--TODO Improve fugitive or remove | Plugin to manage git using the file
	"tpope/vim-fugitive",
	--TODO Really needed?
	"neovim/nvim-lspconfig",
	--TODO Or tune or find alternative | Show color on buffer
	"norcalli/nvim-colorizer.lua",
	-- "dag/vim-fish",
	"preservim/vim-indent-guides",
	-- Automatically insert pairs
	"windwp/nvim-autopairs",
	-- Remembers last cursor location
	"farmergreg/vim-lastplace",
	--TODO Probably remove
	-- "mg979/vim-visual-multi",
	-- Trims white spaces and new lines
	"cappyzawa/trim.nvim",
	-- Auto Format code on save
	"stevearc/conform.nvim",
	-- Auto create the other part of surround
	{ "kylechui/nvim-surround", event = "VeryLazy" },
	--TODO Check if really needed
	-- { "folke/neoconf.nvim",              cmd = "Neoconf" },
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	-- highlighting
	-- { "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },
	"pcolladosoto/tinygo.nvim",
	-------------------------------------------------------
	-- COMPLETION AND HIGHLIGHT
	-- -----------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-context",
		},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- TODO Remove?
			-- "neovim/nvim-lspconfig",
			-- Mason
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Nvim-cmp
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/nvim-cmp",
		},
	},
	-- { 'towolf/vim-helm',       ft = 'helm' },

	-------------------------------------------------------
	-- DEBUGGER
	-- -----------------------------------------------------
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			"nvim-telescope/telescope-dap.nvim",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
	},

	-- -----------------------------------------------------
	--  PRODUCTIVITY
	-- -----------------------------------------------------
	-- Obsidian
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		ft = "markdown",
	},

	"epwalsh/pomo.nvim",
	-- Navigation
	"ThePrimeagen/refactoring.nvim",
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"kristijanhusak/vim-dadbod-completion",
			"tpope/vim-dadbod",
		},
	},
	-- Preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- Colors
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "Mofiqul/dracula.nvim" },

	-- Databases
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
	},
	-- -----------------------------------------------------
	--  MISC
	-- -----------------------------------------------------
	{
		"L3MON4D3/LuaSnip",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	"onsails/lspkind.nvim",
})
