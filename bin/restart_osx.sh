#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title restart_osx
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author gnixaij_oag
# @raycast.authorURL https://raycast.com/gnixaij_oag

osascript -e 'tell application "Ghostty" to quit' 2>/dev/null
osascript -e 'tell application "Visual Studio Code" to quit' 2>/dev/null
osascript -e 'tell app "System Events" to restart'
