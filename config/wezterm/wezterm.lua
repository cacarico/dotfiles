-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local font_size = 10
local font_family = "GoMonoNerdFont"
local background_opacity = 0.9
local background_color = "rgb(27, 24, 28)"
local tab_color = string.format("rgba(27, 24, 28, %f)", background_opacity)

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Catppuccin Mocha'

config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = false

config.window_background_opacity = background_opacity

-- Fonts Configuration
config.font = wezterm.font(font_family)
config.font_size = font_size

-- Bar configuration
config.show_new_tab_button_in_tab_bar = false

config.colors = {
	background = background_color,
	tab_bar = {
		-- background = '#0b0022',

		active_tab = {
			bg_color = tab_color,
			fg_color = "#792EC0",
		},

		inactive_tab = {
			bg_color = tab_color,
			fg_color = "#808080",
		},

		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,
		},
	},
}

-- Config top bar
config.window_frame = {

	font = wezterm.font({ family = font_family, weight = "Bold" }),
	font_size = font_size,
	active_titlebar_bg = tab_color,
	inactive_titlebar_bg = "#333333",
}

-- Ensure that the colors table merges correctly with the color scheme
config.colors = config.colors or {}
config.colors.tab_bar = config.colors.tab_bar or {}

return config
