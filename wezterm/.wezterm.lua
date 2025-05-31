local wezterm = require("wezterm")
local themes = require("/Users/nguyenthong/dotfiles/wezterm/colors_scheme/themes")
local config = wezterm.config_builder()

config.color_schemes = themes
config.color_scheme = "lovelace" -- ặc bạn có thể thay đổi sang theme khác như rose-pine
config.colors = {
	background = "1a1b26", -- Màu nền tokyonight-night
}
--background = "1a1b26", -- Màu nền tokyonight-night

-- Chỉnh sửa cấu hình font
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Monolisa",
	"Maple Mono",
	"FiraCode Nerd Font", -- Phông chữ dự phòng
	"Hack Nerd Font",
	"SF Pro", -- Phông chữ dự phòng
})

config.default_cursor_style = "BlinkingBlock"

config.bold_brightens_ansi_colors = false
config.font_size = 13.0
config.line_height = 1.2
config.window_background_opacity = 1

config.font_rules = {}

config.macos_window_background_blur = 20

config.keys = {
	{ key = "j", mods = "ALT", action = wezterm.action.SendString("") },
	{
		key = ";",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateCopyMode,
	},
}

config.use_ime = true
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.initial_cols = 105
config.initial_rows = 33

config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Hàm tính font size phù hợp
local function adjust_font_size_to_fit(window, pane)
	local window_dims = window:get_dimensions()
	local pane_dims = pane:get_dimensions()

	-- Lấy chiều cao cửa sổ (pixel)
	local window_height_px = window_dims.pixel_height

	-- Lấy số dòng pane hiện tại
	local rows = pane_dims.rows

	-- Hệ số dòng (line height)
	local line_height = config.line_height or 1.0

	-- Chiều cao cell font hiện tại (ước lượng)
	-- WezTerm không expose chiều cao cell trực tiếp, nên ta ước lượng:
	-- cell_height = font_size * hệ số dòng
	-- => font_size = cell_height / line_height
	-- Ta sẽ tính font size mới dựa trên:
	-- font_size_new * line_height * rows = window_height_px
	-- => font_size_new = window_height_px / (rows * line_height)

	local font_size_new = window_height_px / (rows * line_height)

	-- Giới hạn font size để không quá nhỏ hoặc quá lớn
	if font_size_new < 10 then
		font_size_new = 10
	elseif font_size_new > 18 then
		font_size_new = 18
	end

	local overrides = window:get_config_overrides() or {}
	local current_font_size = overrides.font_size or config.font_size
	if false then
		print(current_font_size)
	end

	-- Cập nhật font size nếu khác font_size hiện tại
	if math.abs(font_size_new - config.font_size) > 0.1 then
		window:set_config_overrides({
			font_size = font_size_new,
		})
	end
end

-- Sự kiện window-resized, gọi hàm trên
wezterm.on("window-resized", function(window, pane)
	adjust_font_size_to_fit(window, pane)
end)

return config
