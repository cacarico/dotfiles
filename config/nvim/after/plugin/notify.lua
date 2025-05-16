require("notify").setup({
	background_colour = "#000000",
})

vim.keymap.set("n", "<leader>nx", function()
	require("notify").dismiss()
end)

vim.keymap.set("n", "<leader>tn", "<cmd>Notifications<cr>")
