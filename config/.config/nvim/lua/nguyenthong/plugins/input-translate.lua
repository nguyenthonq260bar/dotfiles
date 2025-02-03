local function create_floating_window(position, opts)
	-- Lấy kích thước màn hình hiện tại
	local ui = vim.api.nvim_list_uis()[1]
	local width = ui.width
	local height = ui.height

	-- Tùy chỉnh kích thước cửa sổ
	local win_width = math.floor((opts.width or 0.5) * width) -- Mặc định chia 50% chiều ngang
	local win_height = math.floor((opts.height or 0.8) * height) -- Chiều cao mặc định 80%

	-- Tính toán vị trí
	local col = 0 -- Mặc định bên trái
	if position == "right" then
		col = width - win_width -- Dịch qua bên phải
	end
	local row = math.floor((height - win_height) / 2) -- Căn giữa theo chiều dọc

	-- Tạo buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- Tạo cửa sổ floating
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = win_width,
		height = win_height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	})

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
	--local lines = vim.split(output, "\n")

	local lines = vim.split(remove_formatting(output), "\n")
	for _, line in ipairs(lines) do
		if line:match("^    ") then -- Chỉ lấy dòng kết quả chính
			return line:gsub("^%s+", "") -- Bỏ khoảng trắng đầu dòng
		end
	end

	-- Trả về kết quả dịch mà không có phần thông tin không cần thiết
	return table.concat(lines, "\n")
end

local function create_input_output_window()
	-- Tạo cửa sổ nhập (input) bên trái
	local input_window = create_floating_window("left", { width = 0.45, height = 0.35 })
	-- Tạo cửa sổ kết quả (output) bên phải
	local output_window = create_floating_window("right", { width = 0.5, height = 0.35 })

	-- Lấy buffer của input và output
	local input_buf = input_window.buf
	local output_buf = output_window.buf

	-- Hiển thị nội dung mặc định cho output
	vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, { "Output will appear here..." })

	-- Xử lý khi người dùng nhập vào input (sự kiện khi nhấn Enter)
	vim.api.nvim_buf_set_keymap(input_buf, "i", "<CR>", "", {
		noremap = true,
		silent = true,
		callback = function()
			-- Lấy dòng văn bản đã nhập
			local lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)
			local input_text = table.concat(lines, " ")

			-- Thực hiện xử lý đầu ra (ở đây bạn có thể thay thế bằng bất kỳ logic nào)
			local result = "Kết quả của: " .. translate_text(input_text)

			-- Cập nhật kết quả vào buffer output
			vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, vim.split(result, "\n"))
		end,
	})

	-- Chuyển cửa sổ nhập vào chế độ nhập
	vim.api.nvim_set_current_win(input_window.win)
	vim.cmd("startinsert")
end

-- Tạo lệnh người dùng để gọi chức năng
vim.api.nvim_create_user_command("InputTranslate", create_input_output_window, {})
