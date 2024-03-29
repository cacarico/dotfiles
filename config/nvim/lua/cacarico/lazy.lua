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

    -- Code
    "airblade/vim-gitgutter",
    "folke/neodev.nvim",
    "lewis6991/gitsigns.nvim",
    "folke/trouble.nvim",
    "nvim-treesitter/playground",
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "neovim/nvim-lspconfig",
    "norcalli/nvim-colorizer.lua",
    "dag/vim-fish",
    "nvim-treesitter/nvim-treesitter-context",
    "preservim/vim-indent-guides",
    "windwp/nvim-autopairs",
    "farmergreg/vim-lastplace",
    "junegunn/goyo.vim",
    "mg979/vim-visual-multi",
    "cappyzawa/trim.nvim",
    { "kylechui/nvim-surround", event = "VeryLazy", },
    { "folke/neoconf.nvim",              cmd = "Neoconf" },
    { "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            {
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" },

            -- Nvim cmp
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",

            -- Snippets
            { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
            'saadparwaiz1/cmp_luasnip',



            --
        }
    },
    -- {
 -- "ray-x/go.nvim",
  -- dependencies = {  -- optional packages
    -- "ray-x/guihua.lua",
  -- },
  -- config = function()
    -- require("go").setup()
  -- end,
  -- event = {"CmdlineEnter"},
  -- ft = {"go", 'gomod'},
  -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
-- },


    -- Obsidian
    "epwalsh/obsidian.nvim",


    -- Debugger
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",


    -- Navigation
    "mhinz/vim-startify",
    "nathom/tmux.nvim",
    "ThePrimeagen/harpoon",
    "ThePrimeagen/refactoring.nvim",
    "stevearc/oil.nvim",
    'akinsho/bufferline.nvim',
    "easymotion/vim-easymotion",
    "mbbill/undotree",
    "folke/which-key.nvim",
    "francoiscabrol/ranger.vim",
    "stevearc/dressing.nvim",
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = "nvim-lua/plenary.nvim"
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    },

    -- Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},

    -- Colors
    { "rose-pine/neovim",             name = "rose-pine" },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    "Mofiqul/dracula.nvim",
    "AlessandroYorba/Alduin",

    -- Wiki
    { "vimwiki/vimwiki" },


})
