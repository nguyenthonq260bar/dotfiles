local wezterm = require('wezterm')
local mux = wezterm.mux
local config = wezterm.config_builder()


-- Define your custom keybindings
config.keys = {
  {key="j", mods="ALT", action=wezterm.action.SendString("")},
}

-- Set other WezTerm configurations
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font("MesloLGS NF")



config.font = wezterm.font_with_fallback({
  "Hack Nerd Font",
  "FiraCode Nerd Font",
  "SF Pro",
})

config.use_ime = true

config.font_size = 19

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.initial_cols = 115
config.initial_rows = 35

config.window_padding = {
  left = 0,
  right = 0,
  bottom = 0,
  top = 0,
}

-- Set window opacity and blur for macOS
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

-- GUI startup behavior
wezterm.on("gui-startup", function()
  local window = mux.spawn_window{}
  window:gui_window():maximize()
end)

-- Return the complete configuration
return config
