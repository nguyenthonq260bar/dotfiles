vim.keymap.set("t", "<ESC><ESC>", "<c-\\><c-n>")

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	-- Get current screen dimensions
	local ui = vim.api.nvim_list_uis()[1]
	local width = ui.width
	local height = ui.height

	-- Set default size (80% of screen)
	local win_width = math.floor((opts and opts.width or 0.8) * width)
	local win_height = math.floor((opts and opts.height or 0.8) * height)

	-- Calculate position for centering the window
	local col = math.floor((width - win_width) / 2)
	local row = math.floor((height - win_height) / 2)

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Set options for the floating window
	local opts = {
		relative = "editor",
		width = win_width,
		height = win_height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Optionally set some options for the buffer
	vim.bo[buf].bufhidden = "wipe" -- Automatically delete the buffer when the window is closed

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.term()
		end

		vim.cmd("startinsert")
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

vim.keymap.set({ "t", "n" }, "|", toggle_terminal)
