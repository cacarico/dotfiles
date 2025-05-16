-- NOTE: understand this shit later
-- Create an augroup for Terraform filetype settings
local terraform_comment_group = vim.api.nvim_create_augroup("TerraformComment", { clear = true })

-- Create the autocmd within the augroup
vim.api.nvim_create_autocmd("FileType", {
	group = terraform_comment_group, -- Assign to the augroup
	pattern = "terraform", -- Match files with 'terraform' filetype
	callback = function()
		vim.bo.commentstring = "// %s" -- Set the commentstring option
	end,
})
