local wezterm = require('wezterm')

-- 'JetBrainsMono Nerd Font','Monaspace Radon Var','DejaVu Sans Mono','Cascadia Code','Comic Sans MS'
-- local font = 'Monaspace Neon Var'
local font_size = 9

return {
	font = wezterm.font_with_fallback({
		{ family = 'Maple Mono NF CN' }
	}),
	font_size = font_size,
	--ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
	freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
	freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
