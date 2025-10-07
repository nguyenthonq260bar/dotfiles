-- ========================================
-- Notify setup
-- ========================================
local notify = require("notify")

notify.setup({
	background_colour = "#1e1e2e",
})

-- ========================================
-- Noice setup
-- ========================================
require("noice").setup({
	notify = {
		enabled = false, -- Ngăn Noice ghi đè vim.notify
	},
	stages = "fade_in_slide_out",
	timeout = 100,
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
	routes = {
		-- Lọc yanked messages
		{
			filter = {
				event = "msg_show",
				find = "yanked",
			},
			opts = { skip = true },
		},
		{
			filter = { event = "msg_show", find = "lines changed" },
			opts = { skip = true },
		},
		-- Lọc messages kiểu "fewer lines"
		{
			filter = {
				event = "msg_show",
				find = "fewer lines",
			},
			opts = { skip = true },
		},
		-- Lọc NvimTree thông báo tạo/xóa file
		{
			filter = {
				event = "msg_show",
				find = "%[NvimTree%]",
			},
			opts = { skip = true },
		},
	},
})
