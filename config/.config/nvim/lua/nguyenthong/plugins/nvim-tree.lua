local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#ffffff guibg=None]])
vim.cmd([[ highlight NvimTreeWinSeparator guifg=#ffffff guibg=None]])

vim.cmd([[ highlight VertSplit guifg=#ffffff guibg=#ff0000 ]]) -- Viền màu trắng, nền đỏ

nvimtree.setup({
	hijack_directories = {
		enable = false, -- tắt hijack khi mở thư mục
		auto_open = true, -- nếu enable, auto_open có thể bật tree
	},

	open_on_setup = false, -- Không tự bật khi mở nvim
	open_on_tab = false, -- Không tự bật khi mở tab
	hijack_cursor = true, -- tùy chọn khác, giữ con trỏ trong tree
	update_cwd = true, -- cập nhật cwd nếu cần
	view = {
		float = {
			enable = false,
		},
		side = "right",
	},
	renderer = {
		highlight_opened_files = "none",

		indent_markers = {
			enable = true,
		},
	},
})

vim.api.nvim_set_hl(0, "VertSplit", { fg = "#ffffff", bg = "None" })

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff", bg = "None" })
