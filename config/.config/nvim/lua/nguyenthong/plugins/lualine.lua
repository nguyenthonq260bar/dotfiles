local status, lualine = pcall(require, "lualine")

if not status then
	return
end

local mode_map = {
	["NORMAL"] = "N", --
	["O-PENDING"] = "N?",
	["INSERT"] = "I",
	["VISUAL"] = "V",
	["V-BLOCK"] = "VB",
	["V-REPLACE"] = "VR",
	["REPLACE"] = "R",
	["COMMAND"] = "C",
	["SHELL"] = "SH",
	["TERMINAL"] = "T",
	["EX"] = "X",
	["S-BLOCK"] = "SB",
	["S-LINE"] = "SL",
	["SELECT"] = "S",
	["CONFIRM"] = "Y?",
	["MORE"] = "M",
}

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#ffffff',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#404040',
  green  = '#a5fc03',
  pink   = '#fa64e6',
  yellow = '#fff530',
  grey2  = '#353835',
}

-- local mytheme = {
-- 	normal = {
-- 		a = { fg = colors.grey2, bg = colors.white, gui = "bold" },
-- 		b = { fg = colors.white, bg = colors.grey },
-- 		c = { fg = colors.white },
-- 	},
-- 	command = { a = { fg = colors.grey2, bg = colors.white, gui = "bold" } },
-- 	insert = { a = { fg = colors.grey2, bg = colors.yellow, gui = "bold" } },
-- 	visual = { a = { fg = colors.white, bg = colors.pink, gui = "bold" } },
-- 	replace = { a = { fg = colors.white, bg = colors.red, gui = "bold" } },
--
-- 	inactive = {
-- 		a = { fg = colors.white, bg = colors.grey, gui = "bold" },
-- 		b = { fg = colors.white, bg = colors.black, gui = "bold" },
-- 		c = { fg = colors.white, bg = colors.grey2, gui = "bold" },
-- 	},
-- }

local custom_theme = {
	normal = {
		a = { fg = "#ffffff", bg = "none" }, -- 'none' để bỏ màu nền
		b = { fg = "#ffffff", bg = "none" },
		c = { fg = "#ffffff", bg = "none" },
	},
	insert = {
		a = { fg = "#ffffff", bg = "none" },
		b = { fg = "#ffffff", bg = "none" },
		c = { fg = "#ffffff", bg = "none" },
	},
	visual = {
		a = { fg = "#ffffff", bg = "none" },
		b = { fg = "#ffffff", bg = "none" },
		c = { fg = "#ffffff", bg = "none" },
	},
	replace = {
		a = { fg = "#ffffff", bg = "none" },
		b = { fg = "#ffffff", bg = "none" },
		c = { fg = "#ffffff", bg = "none" },
	},
	inactive = {
		a = { fg = "#ffffff", bg = "none" },
		b = { fg = "#ffffff", bg = "none" },
		c = { fg = "#ffffff", bg = "none" },
	},
}

function SearchCount()
	local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
	local searchCurrent = search.current
	local searchTotal = search.total
	if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
		return "Search: " .. vim.fn.getreg("/") .. " [" .. searchCurrent .. "/" .. searchTotal .. "]"
	else
		return ""
	end
end

local function dap_status()
	local dap = require("dap")
	return dap.status()
end

local function is_dap_active()
	if not package.loaded.dap then
		return false
	end
	local session = require("dap").session()
	return session ~= nil
end
--
lualine.setup({
	options = {
		theme = custom_theme,
		component_separators = { left = "|", right = "|", use_mode_colors = true },
		section_separators = { left = "", right = "" },
		globalstatus = true,
		disabled_filetypes = { "NvimTree", "TelescopePromt" },
	},
	sections = {
		lualine_a = {
			{ "filetype" },
			{
				"mode",
				separator = { right = "|" },
				right_padding = 2,
				fmt = function(s)
					return mode_map[s] or s
				end,
			},
		},
		lualine_b = {
			{ "diff", symbols = { added = "+", modified = "~", removed = "-" } },
			{ "filename", path = 0 },
			{
				dap_status,
				icon = { " ", color = { fg = "#e7c664" } },
				cond = is_dap_active,
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { { "tabs" } },
		lualine_z = {
			{ "location" },
			{
				SearchCount,
				color = { fg = "#FF5733", gui = "bold" },
			},
			{ "progress" },
			{ "branch" },
		},
	},

	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
})
