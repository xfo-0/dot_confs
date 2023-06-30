local wezterm = require("wezterm")
local config = nil

if wezterm.config_builder then
	config = wezterm.config_builder()
else
	config = {}
end

config.term = "wezterm"
config.automatically_reload_config = true
config.default_prog = { "/usr/bin/zsh" }

-- local ssh_domains = require("extra.ssh")

local fonts = require("fonts")
fonts = fonts.apply_to_config(config)

local colors = require("colors")
colors = colors.apply_to_config(config)

local window = require("window")
window = window.apply_to_config(config)

local scrollback = require("scrollback")
scrollback = scrollback.apply_to_config(config)

local keymaps = require("keymaps")
keymaps.apply_to_config(config)

return config
