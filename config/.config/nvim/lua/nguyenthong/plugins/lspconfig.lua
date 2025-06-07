local mason = require("mason")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local mason_lspconfig = require("mason-lspconfig")
local util = require("lspconfig.util")
mason.setup({
	ui = {
		border = "rounded", -- Tùy chọn giao diện
	},
})

mason_lspconfig.setup({
	ensure_installed = { "html", "cssls", "lua_ls", "gopls" },
})
-- Configure diagnostic signs centrally

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = "✗",
			[vim.diagnostic.severity.WARN] = "⚠",
			[vim.diagnostic.severity.INFO] = "ℹ",
			[vim.diagnostic.severity.HINT] = "➤",
		},
	},
})

--config go
lspconfig.gopls.setup({
	on_attach = function(client, bufnr)
		-- Gán phím tắt khi LSP được đính kèm vào buffer
		vim.keymap.set("n", "-", vim.lsp.buf.hover, { buffer = bufnr }) -- Hiển thị tài liệu
		vim.keymap.set("i", "<C-p>", vim.lsp.buf.signature_help, { buffer = bufnr }) -- Hiển thị chữ ký

		--vim.api.nvim_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>zz", { noremap = true, silent = true })

		vim.api.nvim_set_keymap("n", "gd", "", {
			noremap = true,
			silent = true,
			callback = function()
				vim.lsp.buf.definition()
				vim.cmd("normal! zz")
			end,
		})

		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true }) --import library
	end,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
		},
	},
})

require("go-tags").setup({
	commands = {
		["GoTagsAddJSON"] = { "-add-tags", "json" },
		["GoTagsRemoveJSON"] = { "-remove-tags", "json" },
	},
})

lspconfig.lua_ls.setup({
	-- on_init = function(client)
	-- 	if client.workspace_folders then
	-- 		local path = client.workspace_folders[1].name
	-- 		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. ".luarc.jsonc") then
	-- 			return
	-- 		end
	-- 	end
	-- end,

	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Đảm bảo bạn đang dùng LuaJIT nếu là Neovim
			},
			diagnostics = {
				-- Thêm global để không báo lỗi biến vim undefined
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- Nhận diện thư viện runtime của Neovim
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Cấu hình LSP cho HTML
lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		-- Bật auto-formatting khi lưu file HTML
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
	end,
})

-- Cấu hình LSP cho CSS
lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		-- Bật auto-formatting khi lưu file CSS
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
	end,
})
