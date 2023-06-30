local m_colors = {}

function m_colors.apply_to_config(config)
	-- config.color_scheme = "Banana Blueberry"
	config.colors = {
		foreground = "#cbc0b8",
		background = "black",
		cursor_bg = "#a8a8a8",
		cursor_fg = "#000000",
		cursor_border = "#8a7147",
		selection_fg = "#b7b7b7",
		selection_bg = "#7a7a7a",
		-- The color of the scrollbar "thumb"; the portion that represents the current viewport
		scrollbar_thumb = "#222222",
		split = "#444444",

		ansi = {
			"#2a2827",
			"#af5f5f",
			"#bfb0a2",
			"#e0af68",
			"#af875f",
			"#5c5053",
			"#d7875f",
			"#b9b9b9",
		},
		brights = {
			"#3D3C3B",
			"#bf6c6c",
			"#c9bdb2",
			"#e4bd83",
			"#b3906d",
			"#645b5e",
			"#de916a",
			"#cac8c8",
		},

		-- Arbitrary colors of the palette in the range from 16 to 255
		indexed = { [136] = "#af8700" },
		compose_cursor = "orange",

		-- Colors for copy_mode and quick_select
		-- available since: 20220807-113146-c2fee766
		-- In copy_mode, the color of the active text is:
		-- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
		-- 2. selection_* otherwise
		copy_mode_active_highlight_bg = { Color = "#000000" },
		-- use `AnsiColor` to specify one of the ansi color palette values
		-- (index 0-15) using one of the names "Black", "Maroon", "Green",
		--  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
		-- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
		copy_mode_active_highlight_fg = { AnsiColor = "Black" },
		copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
		copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

		quick_select_label_bg = { Color = "peru" },
		quick_select_label_fg = { Color = "#cbcbcb" },
		quick_select_match_bg = { AnsiColor = "Navy" },
		quick_select_match_fg = { Color = "#bfbfbf" },

		-- retro tab bar appearance
		-- active_tab = {
		-- 	-- The color of the background area for the tab
		-- 	bg_color = "#2b2042",
		-- 	-- The color of the text for the tab
		-- 	fg_color = "#c0c0c0",

		-- 	-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
		-- 	-- label shown for this tab.
		-- 	-- The default is "Normal"
		-- 	intensity = "Normal",

		-- 	-- Specify whether you want "None", "Single" or "Double" underline for
		-- 	-- label shown for this tab.
		-- 	-- The default is "None"
		-- 	underline = "None",

		-- 	-- Specify whether you want the text to be italic (true) or not (false)
		-- 	-- for this tab.  The default is false.
		-- 	italic = false,

		-- 	-- Specify whether you want the text to be rendered with strikethrough (true)
		-- 	-- or not for this tab.  The default is false.
		-- 	strikethrough = false,
		-- },
		-- inactive_tab = {
		-- 	bg_color = "#1b1032",
		-- 	fg_color = "#808080",

		-- 	-- The same options that were listed under the `active_tab` section above
		-- 	-- can also be used for `inactive_tab`.
		-- },
		-- inactive_tab_hover = {
		-- 	bg_color = "#3b3052",
		-- 	fg_color = "#909090",
		-- 	italic = true,

		-- 	-- The same options that were listed under the `active_tab` section above
		-- 	-- can also be used for `inactive_tab_hover`.
		-- },

		-- -- The new tab button that let you create new tabs
		-- new_tab = {
		-- 	bg_color = "#1b1032",
		-- 	fg_color = "#808080",

		-- 	-- The same options that were listed under the `active_tab` section above
		-- 	-- can also be used for `new_tab`.
		-- },

		-- -- You can configure some alternate styling when the mouse pointer
		-- -- moves over the new tab button
		-- new_tab_hover = {
		-- 	bg_color = "#3b3052",
		-- 	fg_color = "#909090",
		-- 	italic = true,

		-- 	-- The same options that were listed under the `active_tab` section above
		-- 	-- can also be used for `new_tab_hover`.
		-- },
	}
end

return m_colors
