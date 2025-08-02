local wezterm = require('wezterm')
local fonts = require('config.fonts')

return {
	color_scheme = "Catppuccin Mocha",
	animation_fps = 60,
	max_fps = 60,
	front_end = 'WebGpu',
	webgpu_power_preference = 'HighPerformance',
	-- scrollbar
	enable_scroll_bar = false,
	-- tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = false,
	tab_max_width = 35,
	show_tab_index_in_tab_bar = true,
	switch_to_last_active_tab_when_closing_tab = true,
	tab_bar_at_bottom = true,
	-- window
	initial_cols = 150,
	initial_rows = 40,
	window_close_confirmation = 'NeverPrompt',
	window_decorations = 'RESIZE',
	window_padding = {
		left = 3,
		right = 3,
		top = 12,
		bottom = 7,
	},
	-- cursor
	cursor_blink_ease_in = 'EaseIn',
	cursor_blink_ease_out = 'EaseOut',
	cursor_blink_rate = 500,
	default_cursor_style = 'BlinkingUnderline',
	cursor_thickness = 4,
	force_reverse_video_cursor = true,
	-- command palette
	command_palette_bg_color = '#222436',
	command_palette_fg_color = '#a4aee8',
	window_frame = {
		active_titlebar_bg = '#090909',
		font = wezterm.font_with_fallback({
			{ family = 'Maple Hand' },
		}),
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.65,
	},
}
