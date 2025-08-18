media=(
  script="$PLUGIN_DIR/media.sh"
  updates=on
)
sketchybar --add item media right \
           --set media "${media[@]}" \/
           --subscribe media media_change