-- Sets nvim to use the shell
vim.o.shell = "/bin/sh"

-- Enables absolute and relative line number
vim.opt.nu = true
vim.opt.relativenumber = true

-- Define your desired purple color
local purple = "#800080" -- Standard purple

-- Set the color for the current line number (CursorLineNr)
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = purple, bold = true })

-- Sets configuration for tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Disables Line wraping
vim.opt.wrap = false

-- NOTE: Check later if swap file should be usefull, sometimes I lose work because the buffer crashes
vim.opt.swapfile = false
vim.opt.backup = false

-- Setups undo
vim.opt.undodir = os.getenv("HOME") .. "/.local/cache/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.conceallevel = 2

-- Set viminfo options
vim.opt.viminfo = "'100,n$HOME/.vim/files/info/viminfo"
