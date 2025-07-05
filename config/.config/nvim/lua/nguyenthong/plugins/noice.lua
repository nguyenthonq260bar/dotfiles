local notify = require("notify")

notify.setup({
	background_colour = "#1e1e2e",
})

require("noice").setup({
	notify = {
		enabled = false, -- 🔧 Ngăn Noice ghi đè vim.notify
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
})
