music=(
  script="$PLUGIN_DIR/music/music.sh"
  icon=􁁒
  label.padding_left=0
  icon.font="$FONT:Regular:18.0"
  label.font="$FONT:Bold:13.0"
  icon.padding_right=8
  label.color=$GREEN
  icon.color=$GREEN
  click_script="rmpc togglepause"
  update_freq=2
  updates=on
)

sketchybar --add item music left \
           --set music "${music[@]}" \
           --subscribe music media_change
