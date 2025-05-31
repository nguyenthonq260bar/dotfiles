local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

-- Khai báo plugin
return packer.startup(function(use)
	-- Quản lý plugin với Packer
	use("wbthomason/packer.nvim")

	-- Plugin hỗ trợ Lua
	use("nvim-lua/plenary.nvim")

	-- Giao diện và UI - colorscheme
	use("bluz71/vim-nightfly-guicolors") -- Giao diện màu "nightfly"
	use("kyazdani42/nvim-web-devicons") -- Biểu tượng cho UI
	use("nvim-lualine/lualine.nvim") -- Thanh trạng thái đẹp
	use("folke/tokyonight.nvim") -- Giao diện màu "tokyonight"
	use("xiyaowong/transparent.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "goolord/alpha-nvim", dependencies = { "nvim-tree/nvim-web-devicons" } })
	use({ "nyoom-engineering/oxocarbon.nvim" })
	use({ "nanozuki/tabby.nvim", dependencies = "nvim-tree/nvim-web-devicons" })

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("navarasu/onedark.nvim")
	use({ "diegoulloao/neofusion.nvim" }) --giao dien mau neofusion

	--Điều hướng
	use("christoomey/vim-tmux-navigator") -- Di chuyển giữa tmux và Vim dễ dàng
	use("szw/vim-maximizer") -- Phóng to/phục hồi cửa sổ
	use("nvim-tree/nvim-tree.lua") -- Trình quản lý file dạng cây

	-- Tìm kiếm và thay thế
	use({
		"nvim-telescope/telescope.nvim", -- Công cụ tìm kiếm mạnh mẽ
		requires = {
			"nvim-lua/plenary.nvim", -- Yêu cầu bởi telescope
			{
				"nvim-telescope/telescope-fzf-native.nvim", -- Tăng tốc tìm kiếm với FZF
				run = "make",
			},
		},
		config = function()
			require("telescope").setup({})
		end,
	})
	-- Công cụ chỉnh sửa -- surround
	--   surr*ound_words             ysiw)           (surround_words)
	--   *make strings               ys$"            "make strings"
	--   [delete ar*ound me!]        ds]             delete around me!
	--   remove <b>HTML t*ags</b>    dst             remove HTML tags
	--   'change quot*es'            cs'"            "change quotes"
	--   <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
	--   delete(functi*on calls)     dsf             function calls
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	use("vim-scripts/ReplaceWithRegister") -- Thay thế văn bản với nội dung trong register
	use("numToStr/Comment.nvim") -- Bình luận/uncomment code nhanh chóng

	-- Hỗ trợ LSP và Autocompletion
	use("neovim/nvim-lspconfig") -- Cấu hình LSP
	use("williamboman/mason.nvim") -- Quản lý LSP và công cụ bổ trợ
	use("williamboman/mason-lspconfig.nvim") -- Tự động cấu hình LSP từ Mason
	use("hrsh7th/nvim-cmp") -- Plugin chính cho autocompletion
	use("hrsh7th/cmp-nvim-lsp") -- Nguồn từ LSP
	use("hrsh7th/cmp-buffer") -- Nguồn từ buffer hiện tại
	use("hrsh7th/cmp-path") -- Nguồn từ đường dẫn file
	use("L3MON4D3/LuaSnip") -- Plugin snippet
	use("saadparwaiz1/cmp_luasnip") -- Tích hợp LuaSnip với nvim-cmp
	use("rafamadriz/friendly-snippets") -- Bộ snippet sẵn có

	use("stevearc/conform.nvim")

	-- Plugin tiện ích khác
	use("otavioschwanck/arrow.nvim") -- Hỗ trợ điều hướng tốt hơn

	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	--debugger
	use({
		"mfussenegger/nvim-dap",
		"leoluz/nvim-dap-go",
	})
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })

	use("sphamba/smear-cursor.nvim")

	use({
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup()
		end,
	})

	use("lukas-reineke/indent-blankline.nvim")
	use("gelguy/wilder.nvim")
	use("max397574/better-escape.nvim")
	use("comfysage/evergarden")
	--plugin for obsidian
	use({
		"epwalsh/obsidian.nvim",
		tag = "*",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({
		"MeanderingProgrammer/render-markdown.nvim",
		after = { "nvim-treesitter" },
		requires = { "echasnovski/mini.nvim", opt = true }, -- if you use the mini.nvim suite
		-- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
		-- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
		config = function()
			require("render-markdown").setup({})
		end,
	})
	--go
	use({
		"devkvlt/go-tags.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})

	-- Cài đặt nvim-colorizer.lua
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({
		"olivercederborg/poimandres.nvim",
		config = function()
			require("poimandres").setup({
				-- leave this setup function empty for default config
				-- or refer to the configuration section
				-- for configuration options
			})
		end,
	})

	use({
		"folke/noice.nvim",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})

	use("MunifTanjim/nui.nvim")
	use("rcarriga/nvim-notify")
	use("karb94/neoscroll.nvim")

	use("HiPhish/rainbow-delimiters.nvim")

	use({
		"kdheepak/lazygit.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	})

	use("github/copilot.vim")
	use({
		"CopilotC-Nvim/CopilotChat.nvim",
		requires = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		run = "make tiktoken", -- tương đương `build` trong Lazy
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				-- Bạn có thể thêm tùy chọn tại đây nếu muốn
			})
		end,
	})
	use("datsfilipe/vesper.nvim")
	if packer_bootstrap then
		require("packer").sync()
	end
end)
