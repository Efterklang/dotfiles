#!/usr/bin/env bash

update() {
  source "$CONFIG_DIR/colors.sh"
  COLOR=$BACKGROUND_2
  if [ "$SELECTED" = "true" ]; then
    COLOR=$GREY
  fi
  sketchybar --set $NAME icon.highlight=$SELECTED \
                         label.highlight=$SELECTED \
                         background.border_color=$COLOR
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

declare -A key_codes=(
  [1]=18 [2]=19 [3]=20 [4]=21 [5]=23
  [6]=22 [7]=26 [8]=28 [9]=25 [10]=29
)

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    # 右键：打开 Mission Control
    osascript -e 'tell application "Mission Control" to activate'
  elif [ "$MODIFIER" = "shift" ]; then
    # Shift+点击：重命名空间
    SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))" 2>/dev/null)"
    if [ $? -eq 0 ]; then
      if [ "$SPACE_LABEL" = "" ]; then
        set_space_label "${NAME:6}"
      else
        set_space_label "${NAME:6} ($SPACE_LABEL)"
      fi
    fi
  else
    osascript -e "tell application \"System Events\" to key code ${key_codes[$SID]} using {control down}" 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
