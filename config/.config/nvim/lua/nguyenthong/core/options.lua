local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true

opt.number = true
opt.fillchars = { eob = " " }

--command defaults
vim.cmd([[autocmd VimEnter * if !argc() | Alpha | endif]])

vim.opt.guifont = "Maple Mono:h14" -- Cấu hình font Maple Mono với kích thước chữ là 14

vim.o.clipboard = "unnamedplus"

vim.cmd("highlight Function gui=bold") -- In đậm cho tên hàm
vim.cmd("highlight Keyword gui=bold") -- In đậm cho từ khóa

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd([[hi LineNr guifg=#3d3d3d]])
		vim.cmd([[hi CursorLineNr guifg=#ff85f3]])
	end,
})
-- Set splitright and splitbelow to avoid creating an additional split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

--search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

--appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--backspace
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus")

--split window
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
