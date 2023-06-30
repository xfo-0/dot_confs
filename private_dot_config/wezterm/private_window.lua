local wezterm = require("wezterm")

local m_window = {}

function m_window.apply_to_config(config)
	config.window_background_opacity = 0.828
	config.window_frame = {
		font = wezterm.font_with_fallback({ family = "Fira Code Nerd Font", weight = "Bold" }),
		font_size = 8.5,
		active_titlebar_bg = "#000000",
		inactive_titlebar_bg = "#000000",
	}
end

return m_window
