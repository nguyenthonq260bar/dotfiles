vim.cmd([[packadd barbecue.nvim]])

local navic = require("nvim-navic")
local barbecue = require("barbecue")
local navbuddy = require("nvim-navbuddy")

-- Thiết lập màu sắc cho WinBar
local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
vim.api.nvim_set_hl(0, "WinBar", { bg = normal_bg, fg = "#cdd6f4" })

barbecue.setup({
	attach_navic = true,
	-- Thay dấu phân cách
	separator = " > ", -- dấu cách + > + dấu cách
	-- Hoặc bạn có thể custom symbol
})

-- Hàm custom xử lý tên symbol

navic.setup({
	-- Có thể để mặc định, hoặc thêm config tùy chỉnh
	highlight = true,
	separator = " > ",
})

navbuddy.setup({
	window = {
		border = "rounded", -- "rounded", "double", "solid", "none", "single",
		-- or an array with eight chars building up the border in a clockwise fashion
		-- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
		size = "80%", -- Or table format example: { height = "40%", width = "100%"}
		position = "70%", -- Or table format example: { row = "100%", col = "0%"}
		scrolloff = nil, -- scrolloff value within navbuddy window
		sections = {
			left = {
				size = "25%",
				border = nil, -- You can set border style for each section individually as well.
			},
			mid = {
				size = "40%",
				border = nil,
			},
			right = {
				-- No size option for right most section. It fills to
				-- remaining area.
				border = nil,
				preview = "leaf", -- Right section can show previews too.
				-- Options: "leaf", "always" or "never"
			},
		},
	},
})
