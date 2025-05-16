---------------------
-- Nvim colorscheme
---------------------

-- Imports catppuccin
require("catppuccin").setup({
	flavour = "frappe", -- latte, frappe, macchiato, mocha
	transparent_background = true,
})

require("dracula").setup({
	transparent_bg = true,
})

function ColorMyPencils(color)
	-- color = color or "rose-pine"
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
