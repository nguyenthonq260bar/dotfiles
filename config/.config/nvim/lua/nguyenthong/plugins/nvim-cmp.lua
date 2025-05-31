require("luasnip/loaders/from_vscode").lazy_load() -- Tải snippet
require("luasnip/loaders/from_vscode").lazy_load({ path = { "~/.config/nvim/snippets" } })

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- icons = {
-- 	Class = "",
-- 	Constructor = "",
-- 	Function = "",
-- 	Keyword = "",
-- 	Method = "",
-- 	Module = "",
-- 	Snippet = "",
-- 	Variable = "",
-- }

vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#e5c07b", bold = true }) -- yellow
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#98c379", bold = true }) -- green
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#61afef", bold = true }) -- blue
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#fadf66", bold = true }) -- red
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#c678dd", bold = true }) -- purple
vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#39e0e3", bold = true }) -- orange
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#e06c75", bold = true }) -- red
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#ff8826", bold = true }) -- yellow
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#56b6c2", bold = true }) -- cyan
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#43d95c", bold = true }) -- blue
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#d19a66", bold = true }) -- orange
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#56b6c2", bold = true }) -- cyan
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#56b6c2", bold = true }) -- cyan
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#e5c07b", bold = true }) -- yellow
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#31d686", bold = true }) -- purple
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#98c379", bold = true }) -- green
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#61afef", bold = true }) -- blue
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#e06c75", bold = true }) -- red
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#61afef", bold = true }) -- blue
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#e06c75", bold = true }) -- red
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#c678dd", bold = true }) -- purple
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#d19a66", bold = true }) -- orange

local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	Event = "",
	Operator = "+",
	TypeParameter = "",

	nvim_lsp = "[LSP]",
	buffer = "🔍",
	luasnip = "📖",
}

cmp.setup({
	preselect = cmp.PreselectMode.Item,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
	},

	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = (kind_icons[vim_item.kind] or "Foo") .. " " .. vim_item.kind
			local source = entry.source.name
			vim_item.menu = " " .. kind_icons[source]

			local item = entry:get_completion_item()

			if item.detail then
				vim_item.menu = item.detail
			end

			function Trim(text)
				local max = 40
				if text and text:len() > max then
					text = text:sub(1, max) .. "..."
				end
				return text
			end

			return vim_item
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		--["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-Space>"] = cmp.mapping.complete(),
		["|"] = cmp.mapping.abort(),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-;>"] = function(fallback)
			if luasnip.in_snippet() then
				luasnip.unlink_current()
			else
				fallback()
			end
		end,
	}),
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			entry_filter = function(entry)
				return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
			end,
		},
		--{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
	}),
	sorting = {
		priority_weight = 2,
	},
	comparators = {
		-- Ưu tiên gợi ý từ luasnip (snippet) lên trước
		function(entry1, entry2)
			if entry1.source.name == "luasnip" and entry2.source.name ~= "luasnip" then
				return true
			elseif entry2.source.name == "luasnip" and entry1.source.name ~= "luasnip" then
				return false
			end
		end,
		-- Ưu tiên snippet theo kiểu (kind)
		function(entry1, entry2)
			local kind1 = entry1:get_kind()
			local kind2 = entry2:get_kind()
			if kind1 == cmp.lsp.CompletionItemKind.Snippet and kind2 ~= cmp.lsp.CompletionItemKind.Snippet then
				return true
			elseif kind2 == cmp.lsp.CompletionItemKind.Snippet and kind1 ~= cmp.lsp.CompletionItemKind.Snippet then
				return false
			end
		end,
		cmp.config.compare.exact,
		cmp.config.compare.offset,
		cmp.config.compare.score,
		cmp.config.compare.kind,
		cmp.config.compare.sort_text,
		cmp.config.compare.length,
		cmp.config.compare.order,
	},
})
