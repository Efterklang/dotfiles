#!/usr/bin/env bash

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'
POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'
ICON_FONT="$FONT:Bold:22.0"
LABEL_FONT="$FONT:Bold:15.0"

apple_logo=(
  icon=$LOGO
  icon.font="$ICON_FONT"
  icon.color=$LAVENDER
  padding_left=10
  padding_right=5
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
)

apple_prefs=(
  icon=$PREFERENCES
  icon.font="$ICON_FONT"
  label="Preferences"
  label.font="$LABEL_FONT"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

apple_activity=(
  icon=$ACTIVITY
  icon.font="$ICON_FONT"
  label="Activity"
  label.font="$LABEL_FONT"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

apple_lock=(
  icon=$LOCK
  icon.font="$ICON_FONT"
  label="Lock Screen"
  label.font="$LABEL_FONT"
  click_script="pmset displaysleepnow; $POPUP_OFF"
)

sketchybar --add item apple.logo left \
  --set apple.logo "${apple_logo[@]}" \
  \
  --add item apple.prefs popup.apple.logo \
  --set apple.prefs "${apple_prefs[@]}" \
  \
  --add item apple.activity popup.apple.logo \
  --set apple.activity "${apple_activity[@]}" \
  \
  --add item apple.lock popup.apple.logo \
  --set apple.lock "${apple_lock[@]}"
