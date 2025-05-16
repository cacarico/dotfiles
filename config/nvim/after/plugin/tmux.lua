-- init.lua or config/tmux.lua
local map = vim.api.nvim_set_keymap
map("n", "<A-h>", [[<cmd>lua require('tmux').move_left()<cr>]], { noremap = true })
map("n", "<A-j>", [[<cmd>lua require('tmux').move_down()<cr>]], { noremap = true })
map("n", "<A-k>", [[<cmd>lua require('tmux').move_up()<cr>]], { noremap = true })
map("n", "<A-l>", [[<cmd>lua require('tmux').move_right()<cr>]], { noremap = true })
