-- Cấu hình colorscheme
local colorscheme = "catppuccin"
-- theme1: nightfly
-- theme2: tokyonight

local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha (chọn màu chủ đạo)
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true, -- Bật chế độ trong suốt
    show_end_of_buffer = false, -- Tắt ký tự '~' ở cuối buffer
    term_colors = true, -- Sử dụng màu trong terminal
    dim_inactive = {
        enabled = true, -- Làm mờ cửa sổ không hoạt động
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Cho phép chữ nghiêng
    no_bold = false, -- Cho phép chữ đậm
    no_underline = false, -- Cho phép gạch dưới
    styles = { -- Thay đổi style của các nhóm highlight
        comments = { "italic" }, -- Comments chữ nghiêng
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = { "italic", "bold" },
        operators = {},
    },
    color_overrides = {}, -- Tùy chỉnh màu sắc (nếu cần)
    custom_highlights = {}, -- Tùy chỉnh highlight nhóm cụ thể
    integrations = {
        cmp = true, -- Tích hợp với nvim-cmp
        gitsigns = true, -- Tích hợp với gitsigns
        nvimtree = true, -- Hỗ trợ NvimTree
        treesitter = true, -- Hỗ trợ Treesitter
        telescope = true, -- Hỗ trợ Telescope
        lsp_trouble = true, -- Hỗ trợ LSP Trouble
        notify = true, -- Hỗ trợ Notify
        mini = {
            enabled = true, -- Hỗ trợ Mini plugins
            indentscope_color = "", -- Mặc định
        },
    },
})

