-- plugins/transparent.lua

require("transparent").setup({
	enable = true, -- Bật tính năng trong suốt
	extra_groups = { -- Các nhóm highlight cần làm trong suốt
		"NormalFloat", -- Các cửa sổ nổi
		"NvimTreeNormal", -- Cửa sổ NvimTree
		--"TelescopeNormal",
		"Tabby",
		"Lualine",
	},
	exclude_groups = { -- Loại trừ các nhóm highlight nếu cần
		"StatusLine", -- Ví dụ loại trừ StatusLine khỏi sự trong suốt
	},
	groups = {
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLine",
		"CursorLineNr",
		"StatusLine",
		"StatusLineNC",
		"EndOfBuffer",
	},
})
