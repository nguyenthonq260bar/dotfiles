-- Set leader key
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

-- ============================================================================
-- General keymaps
-- ============================================================================

-- Prevent yanking on delete
keymap.set({ "n", "v" }, "x", '"_x')
keymap.set("n", "dd", '"_dd')

-- Insert mode escape via 'jk'
keymap.set("i", "jk", "<ESC>")

vim.keymap.set("v", "k", "k", { noremap = true, silent = true })
vim.keymap.set("v", "j", "j", { noremap = true, silent = true })

-- Center search results & navigation
keymap.set("n", "n", "nzz", { noremap = true, silent = true })
keymap.set("n", "N", "Nzz", { noremap = true, silent = true })
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })

-- Wrapped-line movement
keymap.set("n", "j", "gj", { noremap = true, silent = true })
keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- Clear search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Copy current file:line to clipboard
keymap.set("n", "<leader>L", function()
	local file = vim.fn.expand("%")
	local line = vim.fn.line(".")
	vim.fn.setreg("+", string.format("%s:%d", file, line))
	vim.notify("Copied line reference to clipboard")
end, { desc = "Copy line reference to clipboard" })

-- -- Disable default 'a' key mapping (unused)
-- vim.api.nvim_set_keymap("n", "a", "", { noremap = true, silent = true })

-- ============================================================================
-- Window, tab, buffer management
-- ============================================================================

-- Split navigation
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

-- Resize splits
keymap.set("n", "<S-Right>", ":vertical resize +5<CR>")
keymap.set("n", "<S-Left>", ":vertical resize -5<CR>")
keymap.set("n", "<S-Up>", ":resize +2<CR>")
keymap.set("n", "<S-Down>", ":resize -2<CR>")

-- Tab operations
keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

-- Buffer navigation and close
keymap.set("n", "<Leader>,", ":bprev<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>.", ":bnext<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>-", ":bd!<CR>", { noremap = true, silent = true })

-- Smart close current buffer (go prev if exists)
keymap.set("n", "<leader>c", function()
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })
	if #buffers > 1 then
		vim.cmd("bprev")
	end
	vim.cmd("bd!")
end, { noremap = true, silent = true, desc = "Close current buffer" })

-- ============================================================================
-- Visual / Select mode enhancements
-- ============================================================================

-- Indent while keeping selection
keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Move selected lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Escape in visual/x modes
-- keymap.set("x", "o", "<Esc>", { noremap = true, silent = true })
-- keymap.set("v", ".", "<Esc>", { noremap = true, silent = true })

-- Quick text-object selection: inside double quotes
keymap.set("n", "<leader>tt", function()
	vim.cmd('normal! vi"')
end, { noremap = true, silent = true, desc = "Select inside double quotes" })

-- ============================================================================
-- Replace commands (custom functions)
-- ============================================================================

vim.api.nvim_set_keymap("n", "<leader>ra", ":lua ReplaceSelectWord()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>rw", ":lua ReplaceAgreeWord()<CR>", { noremap = true, silent = true })

-- ============================================================================
-- LSP mappings
-- ============================================================================

keymap.set("n", "-", vim.lsp.buf.hover, { buffer = 0 })
keymap.set("i", "<C-p>", vim.lsp.buf.signature_help, { buffer = 0 })

-- ============================================================================
-- Debugger (DAP)
-- ============================================================================

keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "DAP: Continue" })
keymap.set("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "DAP: Step Over" })
keymap.set("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "DAP: Step Into" })
keymap.set("n", "<F12>", function()
	require("dap").step_out()
end, { desc = "DAP: Step Out" })

keymap.set("n", "<Leader>dc", function()
	require("dap").continue()
end, { desc = "DAP: Continue" })
keymap.set("n", "<A-u>", function()
	require("dap").step_over()
end, { desc = "DAP: Step Over" })
keymap.set("n", "<A-i>", function()
	require("dap").step_into()
end, { desc = "DAP: Step Into" })
keymap.set("n", "<A-o>", function()
	require("dap").step_out()
end, { desc = "DAP: Step Out" })
keymap.set("n", "<Leader>dt", function()
	require("dap").toggle_breakpoint()
end, { desc = "DAP: Toggle Breakpoint" })
keymap.set("n", "<Leader>B", function()
	require("dap").set_breakpoint()
end, { desc = "DAP: Set Breakpoint" })
keymap.set("n", "<Leader>dm", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "DAP: Set Log Point" })
keymap.set("n", "<Leader>dr", function()
	require("dap").repl.open()
end, { desc = "DAP: Open REPL" })
keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end, { desc = "DAP: Run Last" })
keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end, { desc = "DAP: Hover" })
keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end, { desc = "DAP: Preview" })
keymap.set("n", "<Leader>df", function()
	local w = require("dap.ui.widgets")
	w.centered_float(w.frames)
end, { desc = "DAP: Frames" })
keymap.set("n", "<Leader>ds", function()
	local w = require("dap.ui.widgets")
	w.centered_float(w.scopes)
end, { desc = "DAP: Scopes" })

-- ============================================================================
-- Plugin integrations
-- ============================================================================

-- Nvim Tree (file explorer)
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Navbuddy (code navigation)
keymap.set("n", "<leader>nb", "<cmd>Navbuddy<cr>", { desc = "Navbuddy: Toggle" })

-- Telescope (fuzzy finder)
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope: Find Files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Telescope: Live Grep" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Telescope: Grep String" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope: Buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope: Help Tags" })
keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Telescope: Registers" })
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Tìm lỗi với Telescope" })
keymap.set("n", "<leader>fm", function()
	local filetype = vim.bo.filetype
	local symbols_map = {
		lua = { "Function" },
		go = { "Method", "Struct", "Interface", "Function", "Variable", "Field", "Type", "Package", "Constant" },
	}
	local symbols = symbols_map[filetype] or { "Function" }
	require("telescope.builtin").lsp_document_symbols({ symbols = symbols })
end, { desc = "LSP symbols by filetype" })

-- Noice (UI enhancements)
keymap.set("n", "<Leader>nd", "<cmd>NoiceDismiss<CR>", { noremap = true, silent = true })

-- Maximizer (split/full screen toggle)
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")
