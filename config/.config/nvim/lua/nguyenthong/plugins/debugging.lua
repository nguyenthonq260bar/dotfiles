local dap = require('dap')
local dapui = require('dapui')
-- Dùng debugpy được cài bởi Mason
local mason_path = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'


vim.fn.sign_define('DapBreakpoint', {text='􀀠', texthl='', linehl='', numhl=''})


dap.adapters.python = {
  type = 'executable',
  command = mason_path, -- Đường dẫn đến debugpy từ Mason
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}', -- File hiện tại
    pythonPath = function()
      return 'python' -- Thay đổi nếu dùng virtual environment hoặc python khác
    end,
  },
}


dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

