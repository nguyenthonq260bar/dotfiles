local status_ok, chat = pcall(require, "CopilotChat")

if not status_ok then
	return
end

chat.setup({
	suggestion = { enable = false },
	panel = { enable = false },

	prompts = {
		Explain = "Giải thích đoạn code sau:",
		Review = "Xem xét đoạn code này và gợi ý cải tiến:",
		Tests = "Viết unit tests cho đoạn code sau:",
		Fix = "Sửa lỗi trong đoạn code này:",
	},
})

-- Tạo biến lưu trạng thái
_G.copilot_enabled = true

-- Keymap để bật / tắt Copilot
vim.keymap.set("n", "<leader>cp", function()
	if _G.copilot_enabled then
		vim.cmd("Copilot disable")
		print("🔌 Copilot disabled")
	else
		vim.cmd("Copilot enable")
		print("⚡ Copilot enabled")
	end
	_G.copilot_enabled = not _G.copilot_enabled
end, { desc = "Toggle Copilot" })

-- Normal mode keymaps
vim.keymap.set({ "n", "v" }, "<leader>zc", ":CopilotChat<CR>", { desc = "Chat with Copilot" })
vim.keymap.set({ "n", "v" }, "<leader>zm", ":CopilotChatCommit<CR>", { desc = "Generate Commit Message" })

-- Visual mode keymaps
vim.keymap.set("v", "<leader>ze", ":CopilotChatExplain<CR>", { desc = "Explain Code" })
vim.keymap.set("v", "<leader>zr", ":CopilotChatReview<CR>", { desc = "Review Code" })
vim.keymap.set("v", "<leader>zf", ":CopilotChatFix<CR>", { desc = "Fix Code Issues" })
vim.keymap.set("v", "<leader>zo", ":CopilotChatOptimize<CR>", { desc = "Optimize Code" })
vim.keymap.set("v", "<leader>zd", ":CopilotChatDocs<CR>", { desc = "Generate Docs" })
vim.keymap.set("v", "<leader>zt", ":CopilotChatTests<CR>", { desc = "Generate Tests" })
vim.keymap.set("v", "<leader>zs", ":CopilotChatCommit<CR>", { desc = "Generate Commit for Selection" })

vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
