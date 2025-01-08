local status, conform = pcall(require, "conform")
if not status then
	return
end

conform.setup({
	formatters_by_ft = {
		css = { "prettier" },
		html = { "prettier" },
		python = { "isort", "black" },
		lua = { "stylua" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 3000,
	},
	stop_after_first = false,
})

vim.keymap.set({ "n", "v" }, "<Leader>ll", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 3000,
	})
end)
