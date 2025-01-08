function ReplaceSelectWord()
  -- Lấy từ hiện tại dưới con trỏ
  local word = vim.fn.expand("<cword>")

  -- Yêu cầu người dùng nhập tên mới
  local new_name = vim.fn.input("New name: ", word)

  -- Nếu người dùng không để trống và nhập tên mới
  if new_name ~= "" then
    -- Thực hiện thay thế với lệnh `:s` và các tham số cần thiết
    -- Cách này thay thế tất cả các từ "word" trong dòng hiện tại
    vim.cmd(":%s/" ..word.. "/" ..new_name.."")
  end
end

function ReplaceAgreeWord()
  local word = vim.fn.expand("<cword>")

  local new_name = vim.fn.input("New name: ", word)

  if new_name ~= "" then
    vim.cmd(":%s/" ..word.. "/" ..new_name.."/gc")
  end
end



