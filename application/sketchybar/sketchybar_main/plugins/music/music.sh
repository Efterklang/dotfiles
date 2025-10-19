#!/bin/bash

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
# Allow override via first arg or env variable
MUSIC_DISPLAY_CONTROLS="${1:-false}"
MAX_LABEL_LENGTH=35

# ────────────────────────────────────
# ▸ Control Functions
# ────────────────────────────────────

next() {
  mpc next
  update
  update_album_art
}

back() {
  mpc prev
  update
  update_album_art
}

play() {
  mpc toggle
  update
}

repeat_toggle() {
  REPEAT=$(mpc status %repeat%)
  if [ "$REPEAT" = "off" ]; then
    sketchybar -m --set music.repeat icon.highlight=on
    mpc repeat on
  else
    sketchybar -m --set music.repeat icon.highlight=off
    mpc repeat off
  fi
}

random_toggle() {
  RANDOM=$(mpc status %random%)
  if [ "$RANDOM" = "off" ]; then
    sketchybar -m --set music.shuffle icon.highlight=on
    mpc random on
  else
    sketchybar -m --set music.shuffle icon.highlight=off
    mpc random off
  fi
}

# ────────────────────────────────────
# ▸ Helper Functions
# ────────────────────────────────────

truncate_text() {
  local text="$1"
  local max_length=${2:-$MAX_LABEL_LENGTH}
  if [ ${#text} -le "$max_length" ]; then
    echo "$text"
  else
    echo "${text:0:max_length}" | sed -E 's/\s+[[:alnum:]]*$//' | awk '{$1=$1};1' | sed 's/$/.../'
  fi
}

update_album_art() {
  local song_path=$(mpc current -f %file% 2>/dev/null)
  local albumart_path="/tmp/music_cover.jpg"
  if mpc readpicture "$song_path" > "$albumart_path" 2>/dev/null && [ -s "$albumart_path" ]; then
    sketchybar -m --set music.cover background.image="$albumart_path" background.color=0x00000000
  else
    # fallback if fail
    sketchybar -m --set music.cover background.image="" background.color=0xff1e1e2e
  fi
}

# ────────────────────────────────────
# ▸ Update Function
# ────────────────────────────────────

update() {
  # Get current state
  local state
  state=$(mpc status 2>/dev/null | grep -oE '\[playing\]|\[paused\]' | tr -d '[]')

  # Early return if no music is playing
  if [ "$state" != "playing" ] && [ "$state" != "paused" ]; then
    return
  fi

  # Set play or pause icon depending on state
  local play_icon="􀊄"
  if [ "$MUSIC_DISPLAY_CONTROLS" = "true" ]; then
    if [ "$state" = "playing" ]; then
      play_icon="􀊆"  # pause icon
    else
      play_icon="􀊄"  # play icon
    fi
  fi

  local title artist album
  title=$(mpc current -f %title% 2>/dev/null)
  artist=$(mpc current -f %artist% 2>/dev/null)
  album=$(mpc current -f %album% 2>/dev/null)

  # Truncate text to fit
  title=$(truncate_text "$title" $((MAX_LABEL_LENGTH * 7/10)))
  artist=$(truncate_text "$artist")
  album=$(truncate_text "$album")

  # Get repeat and shuffle status
  local repeat_status shuffle_status
  repeat_status=$(mpc status %repeat% 2>/dev/null)
  shuffle_status=$(mpc status %random% 2>/dev/null)

  sketchybar -m \
    --set music.anchor label="$title" \
    --set music.title label="$title" \
    --set music.artist label="$artist" \
    --set music.album label="$album" \
    --set music.anchor drawing=on

  # Only update these if controls are enabled
  if [ "$MUSIC_DISPLAY_CONTROLS" = "true" ]; then
    local shuffle_highlight="off"
    local repeat_highlight="off"

    [ "$shuffle_status" = "on" ] && shuffle_highlight="on"
    [ "$repeat_status" = "on" ] && repeat_highlight="on"

    sketchybar -m \
      --set music.shuffle icon.highlight=$shuffle_highlight \
      --set music.repeat icon.highlight=$repeat_highlight \
      --set music.play icon="$play_icon"
  fi
}

# ────────────────────────────────────
# ▸ Scroll Function (Progress Bar)
# ────────────────────────────────────

scroll() {
  # Check if mpc is available
  if ! command -v mpc >/dev/null 2>&1; then
    return
  fi

  # Get current state
  local state
  state=$(mpc status 2>/dev/null | grep -oE '\[playing\]|\[paused\]' | tr -d '[]')

  # Don't update if not playing or paused
  if [ "$state" != "playing" ] && [ "$state" != "paused" ]; then
    return
  fi

  # Get time info from mpc status
  # Format: [playing] #1/123   0:45/3:21 (21%)
  local time_info=$(mpc status | grep -oE '[0-9]+:[0-9]+/[0-9]+:[0-9]+')

  if [ -z "$time_info" ]; then
    return
  fi

  local current_time=$(echo "$time_info" | cut -d'/' -f1)
  local total_time=$(echo "$time_info" | cut -d'/' -f2)

  # Convert time to seconds
  local current_seconds=$(echo "$current_time" | awk -F: '{ print ($1 * 60) + $2 }')
  local total_seconds=$(echo "$total_time" | awk -F: '{ print ($1 * 60) + $2 }')

  if [ "$total_seconds" -gt 0 ] 2>/dev/null; then
    local percentage=$((current_seconds * 100 / total_seconds))
    sketchybar -m --animate linear 10 \
      --set music.state slider.percentage=$percentage \
                        icon="$current_time" \
                        label="$total_time"
  fi
}

# ────────────────────────────────────
# ▸ Scrubbing Function (Seek)
# ────────────────────────────────────

scrubbing() {
  # Get total time from mpc status
  local time_info=$(mpc status | grep -oE '[0-9]+:[0-9]+/[0-9]+:[0-9]+')

  if [ -z "$time_info" ]; then
    return
  fi

  local total_time=$(echo "$time_info" | cut -d'/' -f2)
  local total_seconds=$(echo "$total_time" | awk -F: '{ print ($1 * 60) + $2 }')

  local target=$((total_seconds * PERCENTAGE / 100))

  mpc seek $target 2>/dev/null
  sketchybar -m --set music.state slider.percentage=$PERCENTAGE
}

# ────────────────────────────────────
# ▸ Popup Control
# ────────────────────────────────────

popup() {
  sketchybar -m --set music.anchor popup.drawing=$1
}

# ────────────────────────────────────
# ▸ Routine Handler
# ────────────────────────────────────

routine() {
  case "$NAME" in
    "music.state") scroll
    ;;
    *) update; update_album_art
    ;;
  esac
}

# ────────────────────────────────────
# ▸ Mouse Click Handler
# ────────────────────────────────────

mouse_clicked() {
  case "$NAME" in
    "music.next") next
    ;;
    "music.back") back
    ;;
    "music.play") play
    ;;
    "music.shuffle") random_toggle
    ;;
    "music.repeat") repeat_toggle
    ;;
    "music.state") scrubbing
    ;;
    *) exit
    ;;
  esac
}

# ────────────────────────────────────
# ▸ Main Event Handler
# ────────────────────────────────────

case "$SENDER" in
  "mouse.clicked")
    mouse_clicked
  ;;
  "mouse.exited"|"mouse.exited.global")
    popup off
  ;;
  "routine")
    routine
  ;;
  "forced")
    exit 0
  ;;
  "music_change"|"media_change")
    update
    update_album_art
  ;;
  *)
    # For regular updates (update_freq), check if music is playing
    if ! command -v mpc >/dev/null 2>&1; then
      sketchybar -m --set music.anchor drawing=off popup.drawing=off
      exit 0
    fi

    local state
    state=$(mpc status 2>/dev/null | grep -oE '\[playing\]|\[paused\]' | tr -d '[]')

    if [ "$state" = "playing" ] || [ "$state" = "paused" ]; then
      update
      update_album_art
    else
      # Hide only if not currently showing popup
      sketchybar -m --set music.anchor drawing=off popup.drawing=off
    fi
  ;;
esac
