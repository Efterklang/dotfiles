#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$BLUE
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_2
  slider.knob=􀀁
  slider.knob.drawing=off
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume/volume_click.sh"
  padding_left=5
  icon=$VOLUME_100
  icon.width=0
  icon.align=left
  icon.color=$ROSEWATER
  icon.font="$FONT:Bold:14.0"
  label.width=25
  label.align=left
  label.color=$ROSEWATER
  label.font="$FONT:Bold:14.0"
)

sketchybar --add slider volume right \
  --set volume "${volume_slider[@]}" \
  --subscribe volume volume_change \
  mouse.clicked \
  mouse.entered \
  mouse.exited \
  \
  --add item volume_icon right \
  --set volume_icon "${volume_icon[@]}"
