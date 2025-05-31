local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

local action_state = require("telescope.actions.state")

local function insert_file_path()
	require("telescope.builtin").find_files({
		attach_mappings = function(_, map)
			map("i", "<CR>", function(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				local filepath = selection.path or selection[1]
				local row, col = unpack(vim.api.nvim_win_get_cursor(0))
				vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { filepath })
			end)
			return true
		end,
	})
end

vim.keymap.set("n", "<leader>fp", insert_file_path, { desc = "Insert path with Telescope" })

---keymap <leader>fm - Tìm kiếm các symbols trong file hiện tại dựa trên loại file
vim.keymap.set("n", "<leader>fm", function()
	local filetype = vim.bo.filetype
	local symbols_map = {
		python = { "Function" },
		javascript = { "Function" },
		typescript = { "Function" },
		java = { "Class" },
		lua = { "Function" },
		go = { "Method", "Struct", "Interface" },
	}
	local symbols = symbols_map[filetype] or { "Function" }
	require("telescope.builtin").lsp_document_symbols({
		symbols = symbols,
	})
end, { desc = "LSP symbols by filetype" })

-- Gán vào keymap
--
telescope.setup({
	defaults = {
		prompt_prefix = "  ", -- Thêm biểu tượng cho prompt
		selection_caret = "◆ ", -- Thêm dấu chọn cho mỗi mục
		--layout_strategy = "horizontal", -- Thiết lập bố cục hiển thị theo chiều ngang
		layout_config = {
			horizontal = {
				width = 0.9, -- Chiều rộng của cửa sổ tìm kiếm
				height = 0.8, -- Chiều cao của cửa sổ tìm kiếm
				preview_cutoff = 120, -- Chiều rộng tối thiểu để hiển thị preview
				prompt_position = "top", -- Vị trí của prompt
				preview_width = 0.6, -- Chiều rộng của phần preview
			},
			vertical = {
				width = 0.9,
				height = 0.9,
				preview_cutoff = 40,
				prompt_position = "top",
			},
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
			theme = "ivy",
		},
	},
})
telescope.load_extension("fzf")
