require('glow').setup({
    style = "dark",
    border = "rounded",
    -- width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
    -- height_ratio = 0.7,
})

-- mappings
vim.keymap.set('n', '<leader>m', "<cmd>Glow<CR>", {})
