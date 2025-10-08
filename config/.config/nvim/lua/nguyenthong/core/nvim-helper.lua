function ReplaceSelectWord()
	-- Lấy từ hiện tại dưới con trỏ
	local word = vim.fn.expand("<cword>")

	-- Yêu cầu người dùng nhập tên mới
	local new_name = vim.fn.input("New name: ", word)

	-- Nếu người dùng không để trống và nhập tên mới
	if new_name ~= "" then
		-- Thực hiện thay thế với lệnh `:s` và các tham số cần thiết
		-- Cách này thay thế tất cả các từ "word" trong dòng hiện tại
		vim.cmd(":%s/" .. word .. "/" .. new_name .. "")
	end
end

--------------
function ReplaceAgreeWord()
	local word = vim.fn.expand("<cword>")

	local new_name = vim.fn.input("New name: ", word)

	if new_name ~= "" then
		vim.cmd(":%s/" .. word .. "/" .. new_name .. "/gc")
	end
end

-------------
-- Ham lay duong dan

vim.api.nvim_create_user_command("Path", function()
	local path = vim.fn.expand("%:p:h") -- Lấy đường dẫn thư mục
	vim.fn.setreg("+", path) -- Sao chép vào clipboard (reg +)
end, {})

---------------

-- nvim-help.lua
-- Floating window translator for Neovim using translate-shell

local M = {}

-- Utility: create floating window
local function create_floating_window(opts)
	local ui = vim.api.nvim_list_uis()[1]
	local width = ui.width
	local height = ui.height

	local win_width = math.floor((opts.width or 0.5) * width)
	local win_height = math.floor((opts.height or 0.4) * height)
	local col = math.floor((width - win_width) / 2)
	local row = math.floor((height - win_height) / 2)

	local buf = vim.api.nvim_create_buf(false, true)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = win_width,
		height = win_height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	})

	vim.bo[buf].bufhidden = "wipe"

	return { buf = buf, win = win }
end

-- Remove ANSI codes
local function remove_formatting(text)
	return text:gsub("\027%[[0-9;]*m", "")
end

-- Translate text using translate-shell
local function translate_text(text)
	local cmd = "trans en:vi '" .. text .. "'"
	local output = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		return "Error: Unable to translate"
	end
	output = remove_formatting(output)
	local lines = vim.split(output, "\n")
	-- Take lines starting with spaces (translation output)
	for _, line in ipairs(lines) do
		if line:match("^    ") then
			return line:gsub("^%s+", "")
		end
	end
	return table.concat(lines, "\n")
end

-- Translate from register
function M.translate_from_register()
	local word = vim.fn.getreg('"')
	if word == "" then
		print("No word found in register!")
		return
	end

	local result = translate_text(word)
	local win_data = create_floating_window({ width = 0.5, height = 0.4 })
	vim.api.nvim_buf_set_lines(win_data.buf, 0, -1, false, vim.split(result, "\n"))

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win_data.win, true)
	end, { buffer = win_data.buf, nowait = true, silent = true })
end

-- Translate from input floating window
function M.translate_from_input()
	local input_win = create_floating_window({ width = 0.45, height = 0.3 })
	local output_win = create_floating_window({ width = 0.5, height = 0.3, buf = nil })

	local input_buf = input_win.buf
	local output_buf = output_win.buf

	vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, { "Output will appear here..." })

	vim.api.nvim_buf_set_keymap(input_buf, "i", "<CR>", "", {
		noremap = true,
		silent = true,
		callback = function()
			local lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)
			local input_text = table.concat(lines, " ")
			local result = translate_text(input_text)
			vim.api.nvim_buf_set_lines(output_buf, 0, -1, false, vim.split(result, "\n"))
		end,
	})

	vim.api.nvim_set_current_win(input_win.win)
	vim.cmd("startinsert")
end

-- User commands
vim.api.nvim_create_user_command("TranslateFromRegister", M.translate_from_register, {})
vim.api.nvim_create_user_command("TranslateFromInput", M.translate_from_input, {})

-- Key mappings
vim.keymap.set("n", "-", "<cmd>TranslateFromRegister<CR>", { noremap = true, silent = true })
--vim.keymap.set("n", "<leader>t", "<cmd>TranslateFromInput<CR>", { noremap = true, silent = true })

return M





