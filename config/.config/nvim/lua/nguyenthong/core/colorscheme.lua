-- Cấu hình colorscheme
local colorscheme = "tokyonight-night" -- Chọn một trong các theme sau:

-- theme1: nightfly
-- theme2: tokyonight
-- theme3: catppuccin
-- theme4: neofusion
-- theme5: onedark
-- theme6: oxocarbon
-- theme7: evergarden
-- theme8: vesper
-- theme9: ayu-dark

---@diagnostic disable
local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	vim.cmd("colorscheme tokyonight-night") -- fallback to default colorscheme
	return
end

-- local colors = {
-- 	black = "#000000",
-- 	black2 = "#141313",
-- 	black3 = "#1a1a1a",
-- }
require("catppuccin").setup({
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = true, -- disables setting the background color.
	show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	no_underline = false, -- Force no underline
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	},
	color_overrides = {},
	custom_highlights = {},
	default_integrations = true,
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		mini = {
			enabled = true,
			indentscope_color = "",
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})

-- Lua

require("evergarden").setup({
	transparent_background = false,
	variant = "soft", -- 'hard'|'medium'|'soft'
	override_terminal = true,
	style = {
		tabline = { "reverse" },
		search = { "italic" },
		incsearch = { "reverse" },
		types = { "italic" },
		keyword = { "italic" },
		comment = { "italic" },
		sign = { highlight = false },
	},
	integrations = {
		blink_cmp = true,
		cmp = true,
		gitsigns = true,
		indent_blankline = { enable = true, scope_color = "green" },
		nvimtree = true,
		rainbow_delimiters = true,
		symbols_outline = true,
		telescope = true,
		which_key = true,
	},
	overrides = {}, -- add custom overrides
})
