require('nguyenthong.core.function_keymap')

vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

vim.api.nvim_set_keymap('n', 'a', '', { noremap = true, silent = true })
--general keymaps

keymap.set("n", "x", '"_x')

keymap.set("i", "jk", "<ESC>")

-- keymap.set("n", "j", "jzz", {noremap = true,  silent = true})
-- keymap.set("n", "k", "kzz", {noremap = true, silent = true})

keymap.set("n", "J", "G", {noremap = true, silent = true})
keymap.set("n", "K", "gg",{noremap = true, silent = true})

keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
keymap.set("v", 'i', '<ESC><ESC>', { noremap = true, silent = true })
keymap.set("v", 'n', '<ESC>', { noremap = true, silent = true })

--go to definition fuction
keymap.set('n', '<leader>o', '<C-o>', {noremap = true, silent = true})
keymap.set('n', '<leader>]', '<C-]>', {noremap = true, silent = true})


keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")


keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader>to", ":tabnew<CR>") -- leader tab open
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- leader tab exit
keymap.set("n", "<leader>tn", ":tabn<CR>") -- leader tab next
keymap.set("n", "<leader>tp", ":tabp<CR>") -- leader tab previous

--visual mode
keymap.set('v', 'L', '$', { noremap = true, silent = true })
keymap.set('v', 'H', '^', { noremap = true, silent = true })
keymap.set('v', 'O', '%', { noremap = true, silent = true })


--vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

--nvim tree
keymap.set("n","<leader>e", ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>")




keymap.set("n", "L", "$")
keymap.set("n", "H", "^")
keymap.set("n", "O", "%")


--buffers
vim.keymap.set("n", "<leader>q", function()
  local buffers = vim.fn.getbufinfo({buflisted = 1}) -- Lấy danh sách các buffer đang mở
  if #buffers > 1 then
    vim.cmd("bprev") -- Chuyển sang buffer trước
  end
  vim.cmd("bd!") -- Đóng buffer hiện tại
end, { noremap = true, silent = true })


--move with buffers 
keymap.set('n', '<Leader>.', ':bnext<CR>', { noremap = true, silent = true })
keymap.set('n', '<Leader>,', ':bprev<CR>', { noremap = true, silent = true })
keymap.set('n', '<Leader>-', ':bd!<CR>', { noremap = true, silent = true })

--move code
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })


keymap.set("x", "o", "<Esc>", { noremap = true, silent = true })
keymap.set("v", "o", "<Esc>", { noremap = true, silent = true })


--replace ra - repalce all
vim.api.nvim_set_keymap('n', '<leader>ra', ':lua ReplaceSelectWord()<CR>', { noremap = true, silent = true })

--replace rw - replace wait to agree or disagree
vim.api.nvim_set_keymap('n', '<leader>rw', ':lua ReplaceAgreeWord()<CR>', { noremap = true, silent = true })





--debugger
keymap.set('n', '<F10>', function() require('dap').step_over() end)
keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
keymap.set('n', '<F11>', function() require('dap').step_into() end)
keymap.set('n', '<F12>', function() require('dap').step_out() end)
keymap.set('n', '<Leader>dt', function() require('dap').toggle_breakpoint() end)
keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)



