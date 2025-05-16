local home = os.getenv("HOME")

vim.api.nvim_set_hl(0, "StartifyHeader", { fg = "#f274bd" })
vim.api.nvim_set_hl(0, "StartifyPath", { fg = "#792EC0" })
vim.api.nvim_set_hl(0, "StartifyFile", { fg = "#f274bd" })
vim.api.nvim_set_hl(0, "StartifySlash", { fg = "#f274bd" })

-- Starts indice in 1
local indices = {}
for i = 1, 9 do
	indices[i] = tostring(i)
end

vim.g.startify_custom_indices = indices

vim.g.startify_custom_header = vim.fn["startify#pad"](vim.fn["readfile"](home .. "/.config/nvim/extra/startify.txt"))
vim.g.startify_session_autoload = 1
-- Sets file path relative to project root
vim.g.startify_change_to_vcs_root = 1

local function gitModified()
	local files = vim.fn.systemlist("git ls-files -m 2>/dev/null")
	return vim.tbl_map(function(file)
		return { line = file, path = file }
	end, files)
end

local function gitUntracked()
	local files = vim.fn.systemlist("git ls-files -o --exclude-standard 2>/dev/null")
	return vim.tbl_map(function(file)
		return { line = file, path = file }
	end, files)
end

vim.g.startify_lists = {
	{ type = "dir", header = { "   Project" } },
	{ type = gitModified, header = { "   Modified" } },
	{ type = gitUntracked, header = { "   Untracked" } },
}
