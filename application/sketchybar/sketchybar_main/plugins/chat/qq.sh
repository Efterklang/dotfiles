#!/usr/bin/env bash

qq=(
  update_freq=10
  icon=$QQ
  icon.font="$FONT:Regular:16.0" # 字号要比wechat略小一点，为了协调
  icon.color=$BLUE
  label.font="$FONT:Bold:13.0"
  label.padding_right=2
  script="$PLUGIN_DIR/app_status.sh"
  click_script="open -a qq"
)

sketchybar --add item qq right \
  --set qq "${qq[@]}"
