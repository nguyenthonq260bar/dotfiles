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

  -- Giao diện và UI
  use("bluz71/vim-nightfly-guicolors") -- Giao diện màu "nightfly"
  use("kyazdani42/nvim-web-devicons") -- Biểu tượng cho UI
  use("nvim-lualine/lualine.nvim") -- Thanh trạng thái đẹp
  use("folke/tokyonight.nvim") -- Giao diện màu "tokyonight"
  use("xiyaowong/transparent.nvim")
  use { "catppuccin/nvim", as = "catppuccin" }
  use ({'goolord/alpha-nvim', dependencies= {'nvim-tree/nvim-web-devicons'}})

  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }
  --Điều hướng 
  use("christoomey/vim-tmux-navigator") -- Di chuyển giữa tmux và Vim dễ dàng
  use("szw/vim-maximizer") -- Phóng to/phục hồi cửa sổ
  use("nvim-tree/nvim-tree.lua") -- Trình quản lý file dạng cây

  -- Tìm kiếm và thay thế
  use({
    'nvim-telescope/telescope.nvim', -- Công cụ tìm kiếm mạnh mẽ
    requires = {
      'nvim-lua/plenary.nvim', -- Yêu cầu bởi telescope
      {
        'nvim-telescope/telescope-fzf-native.nvim', -- Tăng tốc tìm kiếm với FZF
        run = 'make',
      },
    },
    config = function()
      require('telescope').setup({})
    end,
  })

  -- Công cụ chỉnh sửa
  use("tpope/vim-surround") -- Quản lý dấu ngoặc nhanh chóng
  use("vim-scripts/ReplaceWithRegister") -- Thay thế văn bản với nội dung trong register
  use("numToStr/Comment.nvim") -- Bình luận/uncomment code nhanh chóng

  -- Hỗ trợ LSP và Autocompletion
  use('neovim/nvim-lspconfig') -- Cấu hình LSP
  use('williamboman/mason.nvim') -- Quản lý LSP và công cụ bổ trợ
  use('williamboman/mason-lspconfig.nvim') -- Tự động cấu hình LSP từ Mason
  use('hrsh7th/nvim-cmp') -- Plugin chính cho autocompletion
  use('hrsh7th/cmp-nvim-lsp') -- Nguồn từ LSP
  use('hrsh7th/cmp-buffer') -- Nguồn từ buffer hiện tại
  use('hrsh7th/cmp-path') -- Nguồn từ đường dẫn file
  use('L3MON4D3/LuaSnip') -- Plugin snippet
  use('saadparwaiz1/cmp_luasnip') -- Tích hợp LuaSnip với nvim-cmp
  use('rafamadriz/friendly-snippets') -- Bộ snippet sẵn có

  -- Plugin tiện ích khác
  use('otavioschwanck/arrow.nvim') -- Hỗ trợ điều hướng tốt hơn 

  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
  }

  use ({'mfussenegger/nvim-dap'})
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

  use "sphamba/smear-cursor.nvim"

  use "lukas-reineke/indent-blankline.nvim"
    if packer_bootstrap then
      require("packer").sync()
    end
end)
