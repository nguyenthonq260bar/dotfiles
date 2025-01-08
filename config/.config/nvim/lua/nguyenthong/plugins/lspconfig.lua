local mason = require('mason')
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local mason_lspconfig = require("mason-lspconfig")



mason.setup({
    ui = {
       border = "rounded", -- Tùy chọn giao diện
    },
})



mason_lspconfig.setup({
  ensure_installed = { 'html', 'cssls', 'pyright', 'lua_ls' },
})


-- Cấu hình LSP cho Python
lspconfig.pyright.setup{
  capabilities = capabilities,
  settings = {
    python = {
      pythonPath = "/Library/Frameworks/Python.framework/Versions/3.13/bin/python3",
    },
  },
}



lspconfig.lua_ls.setup {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path.. '/.luarc.json') or vim.loop.fs_stat(path..'.luarc.jsonc') then
          return
        end
      end
    end,


    settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',  -- Đảm bảo bạn đang dùng LuaJIT nếu là Neovim
      },
      diagnostics = {
        globals = {'vim'},  -- Nhận diện biến `vim`
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),  -- Nhận diện thư viện runtime của Neovim
      },
      telemetry = {
        enable = false,  -- Tắt tính năng gửi dữ liệu telemetry
      },
    },
  },
}

-- Cấu hình LSP cho HTML
lspconfig.html.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Bật auto-formatting khi lưu file HTML
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
  end,
}

-- Cấu hình LSP cho CSS
lspconfig.cssls.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Bật auto-formatting khi lưu file CSS
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
  end,
}
