local wezterm = require("wezterm")

local m_fonts = {}

function m_fonts.apply_to_config(config)
	config.font = wezterm.font_with_fallback({
		{ family = "Fira Code", weight = "DemiBold" },
		"Noto Sans",
		"NotoSansCJK",
		"Noto Sans Symbols",
		"Symbola",
		"Noto Color Emoji",
		{ family = "Symbols Nerd Font Mono", scale = 1.085 },
		-- "Noto Sans Symbols",
	})
	config.font_size = 8.5
	config.default_cursor_style = "SteadyBar"
	config.cursor_thickness = 2.45
end

return m_fonts
