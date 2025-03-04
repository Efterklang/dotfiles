local Config = require('config')
local wezterm = require('wezterm')

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
	options = {
		theme = 'Catppuccin Mocha'
	},
})

return Config:init()
	:append(require('config.appearance'))
	:append(require('config.bindings'))
	:append(require('config.domains'))
	:append(require('config.fonts'))
	:append(require('config.general'))
	:append(require('config.launch')).options
