local wezterm = require("wezterm")
local themes = require("/Users/nguyenthong/dotfiles/wezterm/colors_scheme/themes")
local config = wezterm.config_builder()

config.color_schemes = themes
config.color_scheme = "lovelace" -- Hoặc bạn có thể thay đổi sang theme khác như rose-pine

-- Chỉnh sửa cấu hình font
config.font = wezterm.font_with_fallback({
	"Maple Mono",
	"Hack Nerd Font",
	"Monolisa",
	"FiraCode Nerd Font", -- Phông chữ dự phòng
	"SF Pro", -- Phông chữ dự phòng
})

config.bold_brightens_ansi_colors = false

config.font_size = 13.5
config.line_height = 1.35
config.window_background_opacity = 0.85

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

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
