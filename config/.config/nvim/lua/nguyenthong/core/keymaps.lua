vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

vim.keymap.set("n", "<leader>L", function()
	local file = vim.fn.expand("%")
	local line = vim.fn.line(".")
	vim.fn.setreg("+", string.format("%s:%d", file, line))
	vim.notify("Copied line reference to clipboard")
end, { desc = "Copy line reference to clipboard" })

vim.api.nvim_set_keymap("n", "a", "", { noremap = true, silent = true })
--general keymaps
keymap.set({ "n", "v" }, "x", '"_x')
keymap.set("n", "dd", '"_dd')

-- Di chuyển xuống theo dòng hiển thị (wrap) thay vì dòng thực tế
keymap.set("n", "j", "gj", { noremap = true, silent = true })
-- Di chuyển lên theo dòng hiển thị (wrap) thay vì dòng thực tế
keymap.set("n", "k", "gk", { noremap = true, silent = true })

keymap.set("i", "jk", "<ESC>")

-- keymap.set("n", "QQ", "<cmd>:q!<CR>", { noremap = true, silent = true })
-- keymap.set("n", "WQ", "<cmd>:wq<CR>", { noremap = true, silent = true })
-- keymap.set("n", "WW", "<cmd>:w<CR>", { noremap = true, silent = true })

-- keymap.set("n", "j", "jzz", { noremap = true, silent = true })
-- keymap.set("n", "k", "kzz", { noremap = true, silent = true })

--lspconfig
keymap.set("n", "-", vim.lsp.buf.hover, { buffer = 0 }) -- Hiển thị tài liệu
keymap.set("i", "<C-p>", vim.lsp.buf.signature_help, { buffer = 0 }) -- Hiển thị chữ ký hàm khi đang gõ

keymap.set("n", "N", "Nzz", { noremap = true, silent = true })

keymap.set("n", "n", "nzz", { noremap = true, silent = true })

keymap.set("n", "<Leader>nd", "<cmd>NoiceDismiss<CR>", { noremap = true, silent = true })

-- keymap.set("n", "J", "G", { noremap = true, silent = true })
-- keymap.set("n", "K", "gg", { noremap = true, silent = true })

keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
--keymap.set("v", "i", "<ESC><ESC>", { noremap = true, silent = true })
--keymap.set("v", "n", "<ESC>", { noremap = true, silent = true })

--go to definition fuction
keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
--keymap.set("n", "<leader>]", "<C-]>", { noremap = true, silent = true })

--keymap updown quickly
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

--slip window
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

-- Tăng / giảm chiều rộng
keymap.set("n", "<S-Right>", ":vertical resize +5<CR>")
keymap.set("n", "<S-Left>", ":vertical resize -5<CR>")

-- Tăng / giảm chiều cao
keymap.set("n", "<S-Up>", ":resize +2<CR>")
keymap.set("n", "<S-Down>", ":resize -2<CR>")

--tab & buffers
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader>to", ":tabnew<CR>") -- leader tab open
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- leader tab exit
keymap.set("n", "<leader>tn", ":tabn<CR>") -- leader tab next
keymap.set("n", "<leader>tp", ":tabp<CR>") -- leader tab previous

keymap.set("n", "<Leader>,", ":bprev<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>.", ":bnext<CR>", { noremap = true, silent = true })
keymap.set("n", "<Leader>-", ":bd!<CR>", { noremap = true, silent = true })

-- keymap.set("n", "{", ":tabp<CR>", { noremap = true, silent = true })
-- keymap.set("n", "}", ":tabn<CR>", { noremap = true, silent = true })

--visual mode
-- keymap.set("v", "L", "$", { noremap = true, silent = true })
-- keymap.set("v", "H", "^", { noremap = true, silent = true })
-- keymap.set("v", "O", "%", { noremap = true, silent = true })

vim.api.nvim_set_keymap("x", "<leader>p", '"_dP', { noremap = true, silent = true })
--vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

--nvim tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope: Find Files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Telescope: Live Grep" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Telescope: Grep String" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope: Buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope: Help Tags" })
keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Telescope: Registers" })
vim.keymap.set("n", "<leader>fm", function()
	local filetype = vim.bo.filetype
	local symbols_map = {
		lua = { "Function" },
		go = { "Method", "Struct", "Interface", "Function", "Variable", "Field", "Type", "Package", "Constant" },
	}
	local symbols = symbols_map[filetype] or { "Function" }
	require("telescope.builtin").lsp_document_symbols({
		symbols = symbols,
	})
end, { desc = "LSP symbols by filetype" })

--
-- Đóng buffer hiện tại, chuyển sang buffer trước nếu còn buffer khác
vim.keymap.set("n", "<leader>c", function()
	local buffers = vim.fn.getbufinfo({ buflisted = 1 }) -- Lấy danh sách các buffer đang mở
	if #buffers > 1 then
		vim.cmd("bprev") -- Chuyển sang buffer trước
	end
	vim.cmd("bd!") -- Đóng buffer hiện tại
end, { noremap = true, silent = true }, { desc = "Close current buffer" })

--move code
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

keymap.set("x", "o", "<Esc>", { noremap = true, silent = true })
keymap.set("v", ".", "<Esc>", { noremap = true, silent = true })

--replace ra - repalce all
vim.api.nvim_set_keymap("n", "<leader>ra", ":lua ReplaceSelectWord()<CR>", { noremap = true, silent = true })

--replace rw - replace wait to agree or disagree
vim.api.nvim_set_keymap("n", "<leader>rw", ":lua ReplaceAgreeWord()<CR>", { noremap = true, silent = true })

--

--debugger

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

vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end, { desc = "DAP: Preview" })

vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end, { desc = "DAP: Frames" })

vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, { desc = "DAP: Scopes" })

vim.keymap.set("n", "<leader>tt", function()
	vim.cmd('normal! vi"')
end, { noremap = true, silent = true, desc = "Select inside double quotes" })
