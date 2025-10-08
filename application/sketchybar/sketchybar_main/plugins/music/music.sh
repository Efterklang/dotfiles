#!/usr/bin/env bash
# Credit: https://github.com/ericmckevitt/sketchy-bar-config/blob/main/plugins/music.sh
NAME="music"

export PATH="/opt/homebrew/bin:$PATH"

update_music_bar() {
  local title="$1"
  local artist="$2"

  if [ -n "$title" ] && [ -n "$artist" ]; then
    sketchybar --set "$NAME" drawing=on label="$title — $artist"
    return 0
  fi
  return 1
}

# Check rmpc first
check_rmpc() {
  command -v rmpc >/dev/null && command -v jq >/dev/null || return 1

  local state=$(rmpc status | jq -r '.state' 2>/dev/null | tr '[:upper:]' '[:lower:]')
  [[ "$state" =~ ^(play|pause)$ ]] || return 1

  local title=$(rmpc song | jq -r '.metadata.title' 2>/dev/null)
  local artist=$(rmpc song | jq -r '.metadata.artist' 2>/dev/null)

  update_music_bar "$title" "$artist"
}

# fallback to spotify
check_spotify() {
  pgrep -f "Spotify" >/dev/null || return 1

  local state=$(osascript -e 'tell application "Spotify" to player state' 2>/dev/null)
  [ "$state" = "playing" ] || return 1

  local track=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)
  local artist=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)

  update_music_bar "$track" "$artist"
}

# if not playing, hide
hide_music_bar() {
  sketchybar --set "$NAME" drawing=off label=""
}

check_rmpc || check_spotify || hide_music_bar