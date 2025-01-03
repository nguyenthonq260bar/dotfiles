local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true
opt.fillchars = {eob = " "}

--command defaults
vim.cmd([[autocmd VimEnter * if !argc() | Alpha | endif]])

vim.o.clipboard = 'unnamedplus'



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


