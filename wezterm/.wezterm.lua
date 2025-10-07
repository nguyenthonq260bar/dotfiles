local wezterm = require("wezterm")
--local themes = require("/Users/nguyenthong/dotfiles/wezterm/colors_scheme/themes")
local config = wezterm.config_builder()

--config.color_schemes = themes
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
	"FiraCode Nerd Font",
	"Hack Nerd Font",
	"SF Pro",
})

config.default_cursor_style = "BlinkingBlock"

config.bold_brightens_ansi_colors = false
--config.font_size = 15.0
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

config.animation_fps = 120
config.max_fps = 120
config.front_end = "WebGpu" -- nếu có hỗ trợ

config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Hàm tính font size phù hợp
local function readjust_font_size(window, pane)
	local window_dims = window:get_dimensions()
	local pane_dims = pane:get_dimensions()

	local config_overrides = {}
	local initial_font_size = 12 -- Set to your desired font size
	config_overrides.font_size = initial_font_size

	local max_iterations = 5
	local iteration_count = 0
	local tolerance = 3

	-- Calculate the initial difference between window and pane heights
	local current_diff = window_dims.pixel_height - pane_dims.pixel_height
	local min_diff = math.abs(current_diff)
	local best_font_size = initial_font_size

	-- Loop to adjust font size until the difference is within tolerance or max iterations reached
	while current_diff > tolerance and iteration_count < max_iterations do
		-- Increment the font size slightly
		config_overrides.font_size = config_overrides.font_size + 0.5
		window:set_config_overrides(config_overrides)

		-- Update dimensions after changing font size
		window_dims = window:get_dimensions()
		pane_dims = pane:get_dimensions()
		current_diff = window_dims.pixel_height - pane_dims.pixel_height

		-- Check if the current difference is the smallest seen so far
		local abs_diff = math.abs(current_diff)
		if abs_diff < min_diff then
			min_diff = abs_diff
			best_font_size = config_overrides.font_size
		end

		iteration_count = iteration_count + 1
	end

	-- If no acceptable difference was found, set the font size to the best one encountered
	if current_diff > tolerance then
		config_overrides.font_size = best_font_size
		window:set_config_overrides(config_overrides)
	end
end

wezterm.on("window-resized", function(window, pane)
	readjust_font_size(window, pane)
end)

return config
