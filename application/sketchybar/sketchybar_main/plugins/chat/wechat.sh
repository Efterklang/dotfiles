#!/usr/bin/env bash

wechat=(
	update_freq=10
	icon=$WECHAT
	icon.font="$FONT:Regular:20.0"
	icon.color=$GREEN
	label.font="$FONT:Bold:13.0"
	label.padding_right=2
	script="$PLUGIN_DIR/app_status.sh"
	click_script="open -a Wechat"
)

sketchybar --add item wechat right \
	--set wechat "${wechat[@]}"
