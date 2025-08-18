#!/bin/bash

wifi=(
	icon=$WIFI_ON
	icon.font="$FONT:Regular:17.0"
	icon.padding_left=5
	icon.color=$YELLOW
	script="$PLUGIN_DIR/wifi.sh"
	update_freq=10
)

sketchybar --add item wifi right \
	--set wifi "${wifi[@]}"
