#!/usr/bin/env bash

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app; do
      icon_strip+=" $($CONFIG_DIR/plugins/spaces/icon_map.sh "$app")"
      # debug: 把app写入到~/.cache/app_bar.log, 方便在 icon_map.sh 中自定义图标
      # echo "$app" >>~/.cache/app_bar.log
    done <<<"${apps}"
  else  # empty space
    icon_strip=" :claude:"
  fi

  sketchybar --animate sin 10 --set space.$space label="$icon_strip"
fi
