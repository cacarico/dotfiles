-- Check if 'dap' module is available, otherwise return
local ok, dap = pcall(require, "dap")
if not ok then
	return
end

-- Load necessary plugins and their configurations
require("nvim-dap-virtual-text").setup()
require("dap-go").setup()
require("dapui").setup()

local ensure_installed = {
	"python",
	"bash",
	"cppdbg",
}

local function default_handler(config)
	require("mason-nvim-dap").default_setup(config)
end

-- local function python_handler(config)
--   config.adapters = {
--     filetype = config,
--     command = "/usr/bin/python3",
--     args = {"-m", "debugpy.adapter"},
--   }
--   require("mason-nvim-dap").default_setup(config)
-- end

-- You could add additional handlers for other adapters if needed
-- local function bash_handler(config)
--   -- customize bash adapter configuration here
--   require("mason-nvim-dap").default_setup(config)
-- end

require("mason-nvim-dap").setup({
	ensure_installed = ensure_installed,
	-- handlers = {
	-- 	-- default_handler, -- this is the fallback for adapters with no custom handler
	-- 	function(config)
	-- 		-- all sources with no handler get passed here

	-- 		-- Keep original functionality
	-- 		require("mason-nvim-dap").default_setup(config)
	-- 	end,
	-- },
})

-- Define mappings for DAP commands
vim.keymap.set("n", "<F1>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F4>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>bb", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")
vim.keymap.set("n", "<leader>dd", ":lua require'dapui'.toggle()<CR>")

-- Open and close dapui when debugging starts or ends
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

vim.g.dap_virtual_text = true
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "red", linehl = "", numhl = "" })
