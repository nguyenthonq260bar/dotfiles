local wezterm = require("wezterm")
local themes = require("/Users/nguyenthong/dotfiles/wezterm/colors_scheme/themes")
local config = wezterm.config_builder()
-- Define your custom keybindings

config.color_schemes = themes
config.color_scheme = "lovelace"

config.font = wezterm.font_with_fallback({
	"Maple Mono",
	"Hack Nerd Font",
	"FiraCode Nerd Font",
	"SF Pro",
})
config.window_background_opacity = 1 --0.0 is transparent
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

config.font_size = 19

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
-- Set window opacity and blur for macOS

return config
