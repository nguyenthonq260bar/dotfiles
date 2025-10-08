local wezterm = require("wezterm")
-- Uncomment and edit below to use custom color schemes from a separate file
-- local themes = require("/Users/nguyenthong/dotfiles/wezterm/colors_scheme/themes")
local config = wezterm.config_builder()

-- Set color scheme (change "lovelace" to your preferred theme)
config.color_scheme = "lovelace"
-- Override background color (Tokyonight-night style)
config.colors = {
	background = "1a1b26",
}

-- Font configuration: fallback list for best compatibility
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Monolisa",
	"Maple Mono",
	"FiraCode Nerd Font",
	"Hack Nerd Font",
	"SF Pro",
})

-- Cursor style: blinking block
config.default_cursor_style = "BlinkingBlock"

-- Prevent bold text from brightening ANSI colors
config.bold_brightens_ansi_colors = false
-- config.font_size = 15.0 -- Uncomment to set fixed font size
config.line_height = 1.2
config.window_background_opacity = 1

-- Font rules (empty for now, can be customized)
config.font_rules = {}

-- macOS-specific: enable window background blur
config.macos_window_background_blur = 20

-- Key bindings
config.keys = {
	-- Example: ALT+j does nothing (placeholder)
	{ key = "j", mods = "ALT", action = wezterm.action.SendString("") },
	-- CTRL+SHIFT+; activates copy mode
	{
		key = ";",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivateCopyMode,
	},
}

-- Enable IME (input method editor) for Asian languages
config.use_ime = true
-- Hide tab bar
config.enable_tab_bar = false
-- Window decorations: allow resizing
config.window_decorations = "RESIZE"
-- Initial window size
config.initial_cols = 105
config.initial_rows = 33

-- Animation and rendering settings
config.animation_fps = 120
config.max_fps = 120
config.front_end = "WebGpu" -- Use WebGPU if supported

-- Window padding (no padding)
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Function to dynamically adjust font size based on window and pane dimensions
local function readjust_font_size(window, pane)
	local window_dims = window:get_dimensions()
	local pane_dims = pane:get_dimensions()

	local config_overrides = {}
	local initial_font_size = 12 -- Starting font size
	config_overrides.font_size = initial_font_size

	local max_iterations = 5
	local iteration_count = 0
	local tolerance = 3

	-- Calculate initial difference between window and pane heights
	local current_diff = window_dims.pixel_height - pane_dims.pixel_height
	local min_diff = math.abs(current_diff)
	local best_font_size = initial_font_size

	-- Iteratively adjust font size to minimize difference
	while current_diff > tolerance and iteration_count < max_iterations do
		-- Increase font size slightly
		config_overrides.font_size = config_overrides.font_size + 0.5
		window:set_config_overrides(config_overrides)

		-- Update dimensions after changing font size
		window_dims = window:get_dimensions()
		pane_dims = pane:get_dimensions()
		current_diff = window_dims.pixel_height - pane_dims.pixel_height

		-- Track best font size found so far
		local abs_diff = math.abs(current_diff)
		if abs_diff < min_diff then
			min_diff = abs_diff
			best_font_size = config_overrides.font_size
		end

		iteration_count = iteration_count + 1
	end

	-- If no acceptable difference found, use best font size encountered
	if current_diff > tolerance then
		config_overrides.font_size = best_font_size
		window:set_config_overrides(config_overrides)
	end
end

-- Automatically adjust font size when window is resized
wezterm.on("window-resized", function(window, pane)
	readjust_font_size(window, pane)
end)

return config
