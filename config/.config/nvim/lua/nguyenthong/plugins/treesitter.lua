local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	modules = {},
	ignore_install = {},
	auto_install = true,
	sync_install = false,

	ensure_installed = { "lua", "javascript", "markdown", "markdown_inline", "go" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})

-- Cấu hình trong file init.lua
vim.g.rainbow_delimiters = require("rainbow-delimiters")

-- vim.api.nvim_set_hl(0, "@variable", { italic = true })
-- vim.api.nvim_set_hl(0, "@comment", { italic = true, fg = "#888888" })
