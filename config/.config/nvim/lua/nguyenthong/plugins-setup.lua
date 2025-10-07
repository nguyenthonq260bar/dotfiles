-- Tự động cài đặt Packer nếu chưa có
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

-- Tự động chạy PackerCompile khi lưu file này
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerCompile
  augroup end
]])

-- Khởi tạo plugin
local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- Quản lý plugin
	use("wbthomason/packer.nvim")

	-- Thư viện Lua
	use("nvim-lua/plenary.nvim")

	-- Giao diện / UI - theme
	use("echasnovski/mini.icons")
	use("Shatur/neovim-ayu")
	use("aliqyan-21/darkvoid.nvim")
	use("marko-cerovac/material.nvim")
	use("bluz71/vim-nightfly-guicolors")
	use("rose-pine/neovim")
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lualine/lualine.nvim")
	use("folke/tokyonight.nvim")
	use("xiyaowong/transparent.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "nyoom-engineering/oxocarbon.nvim" })
	use({ "diegoulloao/neofusion.nvim" })
	use({
		"olivercederborg/poimandres.nvim",
		config = function()
			require("poimandres").setup()
		end,
	})
	use({ "comfysage/evergarden" })
	use({ "datsfilipe/vesper.nvim" })
	use({ "nanozuki/tabby.nvim", requires = "nvim-tree/nvim-web-devicons" })
	use({ "goolord/alpha-nvim", requires = "nvim-tree/nvim-web-devicons" })

	-- Thanh trạng thái, cuộn, highlight
	use("lukas-reineke/indent-blankline.nvim")
	use("karb94/neoscroll.nvim")
	use("sphamba/smear-cursor.nvim")
	use({
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup()
		end,
	})

	-- Cây cấu trúc file
	use("nvim-tree/nvim-tree.lua")

	-- Điều hướng và chuyển đổi cửa sổ
	use("christoomey/vim-tmux-navigator")
	use("szw/vim-maximizer")
	use("otavioschwanck/arrow.nvim")

	-- Tìm kiếm nâng cao
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	-- Công cụ hỗ trợ soạn thảo
	use("vim-scripts/ReplaceWithRegister")
	use("numToStr/Comment.nvim")
	use("max397574/better-escape.nvim")
	use("windwp/nvim-autopairs")
	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup()
		end,
	})

	-- Rainbow Delimiters
	use("HiPhish/rainbow-delimiters.nvim")

	-- Plugin hỗ trợ Markdown/Obsidian
	use({ "epwalsh/obsidian.nvim", tag = "*", requires = { "nvim-lua/plenary.nvim" } })
	use({
		"MeanderingProgrammer/render-markdown.nvim",
		after = { "nvim-treesitter" },
		requires = { "echasnovski/mini.nvim", opt = true },
		config = function()
			require("render-markdown").setup()
		end,
	})

	-- Highlight màu sắc
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- LSP và Tự động hoàn thành
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- Định dạng mã
	use("stevearc/conform.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- Debugger
	use({ "mfussenegger/nvim-dap" })
	use({ "leoluz/nvim-dap-go" })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })

	-- LazyGit
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

	-- Copilot + Chat
	use("github/copilot.vim")
	use({
		"CopilotC-Nvim/CopilotChat.nvim",
		requires = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		run = "make tiktoken",
	})

	-- which-key
	use("folke/which-key.nvim")

	-- Barbecue, Navic, Navbuddy
	use({
		"utilyre/barbecue.nvim",
		tag = "*",
		requires = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		after = "nvim-web-devicons",
	})
	use({
		"SmiteshP/nvim-navbuddy",
		requires = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
			"numToStr/Comment.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	-- Go tools
	use({
		"devkvlt/go-tags.nvim",
		-- requires = { "nvim-treesitter/nvim-treesitter" },
	})

	use({
		"rachartier/tiny-inline-diagnostic.nvim",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
		end,
	})

	use({ "noahfrederick/vim-hemisu" })

	use({
		"folke/noice.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	})

	-- Sync packer nếu lần đầu cài
	if packer_bootstrap then
		require("packer").sync()
	end
end)
