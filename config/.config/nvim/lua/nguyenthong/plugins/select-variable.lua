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
