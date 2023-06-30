local wezterm = require("wezterm")

local m_scrollback = {}

function m_scrollback.apply_to_config(config)
	config.scrollback_lines = 10000
	config.enable_scroll_bar = true
	config.hyperlink_rules = wezterm.default_hyperlink_rules()
	table.insert(config.hyperlink_rules, {
		regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
		format = "https://www.github.com/$1/$3",
	})
end

return m_scrollback
