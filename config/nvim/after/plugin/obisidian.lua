require("obsidian").setup({
	ui = { enable = false },
	workspaces = {
		{
			name = "personal",
			path = "~/Documents/Obsidian/",
		},
	},
	completion = {
		nvim_cmp = true, -- If you're using nvim-cmp for completion
	},
	templates = {
		folder = "~/Documents/Obsidian/Templates/",
		date_format = "%Y-%m-%d-%a",
		time_format = "%H:%M",
	},
	follow_url_func = function(url)
		-- Open the URL in the default web browser.
		vim.notify("Opening URL: " .. url, vim.log.levels.INFO)
		vim.fn.jobstart({ "brave-nightly", url }) -- Mac OS

		-- vim.fn.jobstart({"xdg-open", url})  -- linux
		-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
		-- vim.ui.open(url) -- need Neovim 0.10.0+
	end,
})

vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Search note on Obsidian" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
vim.keymap.set("n", "<leader>oN", "<cmd>ObsidianNew<CR>", { desc = "Insert Obsidian Template" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNewFromTemplate<CR>", { desc = "Insert Obsidian from Template" })
vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename Obsidian Note" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianFollowLink<CR>", { desc = "Opens url on browser" })
