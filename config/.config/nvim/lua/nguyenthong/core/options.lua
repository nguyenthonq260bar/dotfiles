local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true
opt.virtualedit = "onemore"

vim.o.startofline = false

opt.fillchars = { eob = " " }

vim.opt.conceallevel = 1

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
		vim.cmd([[hi StatusLine guibg=none]])
		vim.cmd([[hi LineNrAbove guifg=#ff5189]])
		vim.cmd([[hi LineNrbelow guifg=#ffffff]])
	end,
})
-- Set splitright and splitbelow to avoid creating an additional split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
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
opt.compatible = false
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus")

--split window
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

vim.g.loaded_perl_provider = 0

vim.o.guicursor = table.concat({
	"n-v-c:block", -- Normal/Visual/Command: block cursor
	"i-ci:ver25", -- Insert: vertical bar (25% height)
	"r-cr:hor20", -- Replace: horizontal bar (20% height)
	"sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch: blinking block
}, ",")
