local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

require("luasnip/loaders/from_vscode").lazy_load() -- Tải snippet
require("luasnip/loaders/from_vscode").lazy_load({ path = { "~/.config/nvim/snippets" } })

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- Sử dụng LuaSnip cho snippet
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Di chuyển lên
		["<C-j>"] = cmp.mapping.select_next_item(), -- Di chuyển xuống
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-Space>"] = cmp.mapping.complete(), -- Hiển thị menu gợi ý
		["<C-e>"] = cmp.mapping.abort(), -- Hủy bỏ autocompletion
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Chấp nhận gợi ý
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- Gợi ý từ LSP
		{ name = "buffer" }, -- Gợi ý từ buffer hiện tại
		{ name = "path" }, -- Gợi ý từ đường dẫn
		{ name = "luasnip" }, -- Gợi ý snippet
	}),
})
