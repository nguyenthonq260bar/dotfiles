local status, better_escape = pcall(require, "better_escape")

if not status then
	return
end

better_escape.setup({
	mapping = { "jk", "kj" }, -- sequence thoát
	timeout = 200, -- ms, thời gian nhận sequence
	clear_empty_lines = false,
	keys = "<Esc>",
	-- ensure it only works in insert mode
	mode = "i",
})
