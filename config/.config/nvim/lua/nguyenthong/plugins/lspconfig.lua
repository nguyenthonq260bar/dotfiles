--==================================
--Cấu hình LSP với mason và mason-lspconfig
--==================================
local mason = require("mason")
--local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local mason_lspconfig = require("mason-lspconfig")
local util = require("lspconfig.util")
local navic = require("nvim-navic")
local navbuddy = require("nvim-navbuddy")

--==================================
--Cài đặt các server LSP tự động
--==================================
mason.setup({
	ui = {
		border = "rounded", -- Tùy chọn giao diện
	},
})

mason_lspconfig.setup({
	ensure_installed = { "html", "cssls", "lua_ls", "gopls" },
})
--==================================
--Cấu hình chung cho tất cả các server
--==================================
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
--==================================
--Go lspconfig
--==================================
--
vim.lsp.config("gopls", {
	settings = {
		["gopls"] = {
			completeUnimported = true,
			usePlaceholders = true,
		},
	},

	-- settings = {
	-- 	gopls = {
	-- 		completeUnimported = true,
	-- 		usePlaceholders = true,
	-- 	},
	-- },
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
			navbuddy.attach(client, bufnr)
		end

		-- Gán phím tắt khi LSP được đính kèm vào buffer
		vim.keymap.set("n", "-", vim.lsp.buf.hover, { buffer = bufnr }) -- Hiển thị tài liệu
		vim.keymap.set("i", "<C-p>", vim.lsp.buf.signature_help, { buffer = bufnr }) -- Hiển thị chữ ký

		--vim.api.nvim_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>zz", { noremap = true, silent = true })

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
			--vim.cmd("normal!zz")
		end, { noremap = true, silent = true, buffer = bufnr })

		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true }) --import library
	end,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "gomod", "gowork", "gotmpl" },
	callback = function(args)
		vim.lsp.start(vim.lsp.get_config("gopls"), { bufnr = args.buf })
	end,
})

--config go lspconfig "cũ"
-- local lspconfig = require("lspconfig")
--
-- lspconfig.gopls.setup({
-- 	settings = {
-- 		gopls = {
-- 			completeUnimported = true,
-- 			usePlaceholders = true,
-- 		},
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		vim.keymap.set("n", "-", vim.lsp.buf.hover, { buffer = bufnr })
-- 		vim.keymap.set("i", "<C-p>", vim.lsp.buf.signature_help, { buffer = bufnr })
-- 		vim.keymap.set("n", "gd", function()
-- 			vim.lsp.buf.definition()
-- 		end, { noremap = true, silent = true, buffer = bufnr })
-- 		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
--
-- 		if client.server_capabilities.documentSymbolProvider then
-- 			navic.attach(client, bufnr)
-- 			navbuddy.attach(client, bufnr)
-- 		end
-- 	end,
-- 	capabilities = capabilities,
-- 	cmd = { "gopls" },
-- 	filetypes = { "go", "gomod", "gowork", "gotmpl" },
-- 	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
-- })
--
require("go-tags").setup({
	commands = {
		["GoTagsAddJSON"] = { "-add-tags", "json" },
		["GoTagsRemoveJSON"] = { "-remove-tags", "json" },
	},
})

--==================================
--Lua LSP
--==================================
vim.lsp.config("lua_ls", {
	settings = {
		["lua_ls"] = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	on_attach = function(client, bufnr)
		-- Chỉ attach navic nếu server hỗ trợ documentSymbolProvider
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
			navbuddy.attach(client, bufnr)
		end
	end,
})

-- require("lspconfig").lua_ls.setup({
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = "LuaJIT",
-- 			},
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		-- Chỉ attach navic nếu server hỗ trợ documentSymbolProvider
-- 		if client.server_capabilities.documentSymbolProvider then
-- 			navic.attach(client, bufnr)
-- 			navbuddy.attach(client, bufnr)
-- 		end
-- 	end,
-- })

--==================================
--HTML, CSS LSP
--==================================
vim.lsp.config("html", {
	settings = {
		["html"] = {},
	},
	capabilities = capabilities,
	on_attach = function()
		-- Bật auto-formatting khi lưu file HTML
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
	end,
})
-- lspconfig.html.setup({
-- 	capabilities = capabilities,
-- 	on_attach = function(client, bufnr)
-- 		-- Bật auto-formatting khi lưu file HTML
-- 		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
-- 	end,
-- })

-- Cấu hình LSP cho CSS
vim.lsp.config("cssls", {
	settings = {
		["cssls"] = {},
	},
	capabilities = capabilities,
	on_attach = function()
		-- Bật auto-formatting khi lưu file CSS
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
	end,
})

--==================================
--Nvim-navic, navbuddy
--==================================
navic.setup({})

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

navbuddy.setup({
	window = {
		border = "rounded", -- Thiết lập viền cửa sổ
	},
})
