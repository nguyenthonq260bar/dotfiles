local function create_floating_window(win_opts)
	-- Get current screen dimensions
	local ui = vim.api.nvim_list_uis()[1]
	local width = ui.width
	local height = ui.height

	-- Set default size (80% of screen)
	local win_width = math.floor((win_opts and win_opts.width or 0.8) * width)
	local win_height = math.floor((win_opts and win_opts.height or 0.8) * height)

	-- Calculate position for centering the window
	local col = math.floor((width - win_width) / 2)
	local row = math.floor((height - win_height) / 2)

	-- Create a buffer if not passed in opts
	local buf = win_opts.buf
	if not buf or not vim.api.nvim_buf_is_valid(buf) then
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Set options for the floating window
	local win_settings = {
		relative = "editor",
		width = win_width,
		height = win_height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_settings)

	-- Optionally set some options for the buffer
	vim.bo[buf].bufhidden = "wipe" -- Automatically delete the buffer when the window is closed

	return { buf = buf, win = win }
end

local function remove_formatting(text)
	-- Loại bỏ mã định dạng ANSI
	return text:gsub("\027%[[0-9;]*m", "")
end

local function translate_text(text)
	-- Gọi lệnh dịch (sử dụng `trans` từ translate-shell)
	local cmd = "trans en:vi '" .. text .. "'"
	local output = vim.fn.system(cmd)

	-- Kiểm tra lỗi
	if vim.v.shell_error ~= 0 then
		return "Error: Unable to translate"
	end
	-- Loại bỏ các mã định dạng
	output = remove_formatting(output)
	local lines = vim.split(output, "\n")

	-- Trả về kết quả dịch mà không có phần thông tin không cần thiết
	return table.concat(lines, "\n")
end

local function translate_from_register()
	-- Lấy từ trong register
	local word = vim.fn.getreg('"') -- Register " (clipboard or default register)

	if word == "" then
		-- Nếu không có từ nào trong register, thông báo lỗi
		print("No word found in register!")
		return
	end

	-- Dịch từ đó
	local result = translate_text(word)

	-- Hiển thị kết quả trong một cửa sổ mới
	local preview_window = create_floating_window({ width = 0.5, height = 0.7 })
	local buf = preview_window.buf
	local win = preview_window.win
	--vim.api.nvim_buf_set_option(buf, "modifiable", true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, "\n"))

	--bấm q sẽ thoát buffer
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf, nowait = true, silent = true })
end

-- Tạo lệnh người dùng để gọi chức năng
vim.api.nvim_create_user_command("TranslateFromRegister", translate_from_register, {})

--vim.keymap.set("n", "*", translate_from_register)

vim.keymap.set("n", "<C-p>", function()
	-- Yanking từ dưới con trỏ (word dưới con trỏ)
	vim.cmd("normal! yw")

	-- Gọi lệnh dịch từ trong register
	vim.cmd("TranslateFromRegister")
end, { noremap = true, silent = true })
