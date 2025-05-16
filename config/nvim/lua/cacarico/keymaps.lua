vim.g.mapleader = " "

-- Disables Q
vim.keymap.set("n", "Q", "<nop>")

-- Moves visualy select text up and down with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Appends next Line
vim.keymap.set("n", "J", "mzJ`z")

-- Center the screen after scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Centers the search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Deletes the selected visual and paste from register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Delete without yanking
vim.keymap.set({ "n", "x", "o" }, "<leader>d", '"_d')
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Leave insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<ESC>:w <CR>")
-- Sed commands
--
-- Replace all occurrences of the current word under the cursor with the same word
vim.keymap.set("n", "<leader>sg", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]])

-- Change panes using Alt hjkl
vim.keymap.set("n", "<A-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<A-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<A-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<A-l>", "<C-w>l", { noremap = true })

-- -- Moves using Ctrl hjkl in during inert mode
-- vim.keymap.set("i", "<C-h>", "<C-o>h", { desc = "Move one character left in insert mode" })
-- vim.keymap.set("i", "<C-j>", "<C-o>j", { desc = "Move one character down in insert mode" })
-- vim.keymap.set("i", "<C-k>", "<C-o>k", { desc = "Move one character up in insert mode" })
-- vim.keymap.set("i", "<C-l>", "<C-o>l", { desc = "Move one character right in insert mode" })

vim.keymap.set("n", "<C-c>", ":q<CR>", { noremap = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "[b]uffer [d]elete" })
vim.keymap.set("n", "<C-q>", ":qa<CR>", { noremap = true })
vim.keymap.set("n", "<C-S-q>", ":qa!<CR>", { noremap = true })

-- Resize split
vim.keymap.set("n", "<A-S-l>", ":vertical resize +5<CR>")
vim.keymap.set("n", "<A-S-k>", ":resize +5<CR>")
vim.keymap.set("n", "<A-S-j>", ":resize -5<CR>")
vim.keymap.set("n", "<A-S-h>", ":vertical resize -5<CR>")

-- Move split
vim.keymap.set("n", "<A-C-h>", "<C-w>H", { silent = true })
vim.keymap.set("n", "<A-C-j>", "<C-w>J", { silent = true })
vim.keymap.set("n", "<A-C-k>", "<C-w>K", { silent = true })
vim.keymap.set("n", "<A-C-l>", "<C-w>L", { silent = true })

-- Windows
vim.keymap.set("n", "\\\\", ":vsplit<CR>")

-- Starts lazyvim in the current project
vim.keymap.set("n", "<C-g>", "<cmd>silent !fish -c 'floating_git'<CR>")

vim.keymap.set("n", "<leader>tw", function()
	if vim.wo.wrap then
		vim.wo.wrap = false
		print("Line wrap disabled")
	else
		vim.wo.wrap = true
		print("Line wrap enabled")
	end
end, { desc = "[t]oggle Line [w]rap" })
