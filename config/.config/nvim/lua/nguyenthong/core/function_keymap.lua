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
local telescope = require("telescope.builtin")
local select = require("vim.ui").select

-- Hàm để chọn loại symbol và tìm kiếm với telescope
function Search_symbol()
	-- Các tùy chọn cho menu
	local options = { "method", "function", "variable" }

	-- Hiển thị menu để người dùng chọn
	select(options, {
		prompt = "<---- Select value: ---->",
		format_item = function(item)
			return item
		end,
	}, function(choice)
		if choice == "method" then
			-- Tìm kiếm các method
			telescope.lsp_document_symbols({ symbols = { "method" } })
		elseif choice == "function" then
			-- Tìm kiếm các function
			telescope.lsp_document_symbols({ symbols = { "function" } })
		elseif choice == "variable" then
			-- Tìm kiếm các variable
			telescope.lsp_document_symbols({ symbols = { "variable" } })
		end
	end)
end

-- Gán phím tắt ':lua sea' cho hàm Search_symbol
--vim.api.nvim_set_keymap("n", "<leader>fm", ":lua Search_symbol()<CR>", { noremap = true, silent = true })

--
