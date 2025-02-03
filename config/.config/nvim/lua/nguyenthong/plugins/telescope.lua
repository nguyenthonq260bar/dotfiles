local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end
--

telescope.setup({
	defaults = {
		prompt_prefix = "  ", -- Thêm biểu tượng cho prompt
		selection_caret = "◆ ", -- Thêm dấu chọn cho mỗi mục
		layout_strategy = "horizontal", -- Thiết lập bố cục hiển thị theo chiều ngang
		layout_config = {
			width = 0.8, -- Đặt chiều rộng cửa sổ
			height = 0.75, -- Đặt chiều cao cửa sổ
			preview_width = 0.55, -- Đặt chiều rộng phần xem trước (tăng kích thước)
		},
		color_devicons = true, -- Hiển thị biểu tượng cho các file
	},
	mappings = {
		i = {
			["<Esc>"] = actions.close, -- Đóng Telescope khi nhấn Esc
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			previewer = true, -- Bật phần preview
		},
	},
})
telescope.load_extension("fzf")
