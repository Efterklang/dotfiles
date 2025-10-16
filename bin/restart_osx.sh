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

# 关闭 Ghostty 应用
echo "关闭 Ghostty..."
osascript -e 'tell application "Ghostty" to quit' 2>/dev/null

# 关闭 Visual Studio Code 应用
echo "关闭 Visual Studio Code..."
osascript -e 'tell application "Visual Studio Code" to quit' 2>/dev/null

# 等待应用关闭
echo "等待应用关闭..."
sleep 5

# 重启电脑
echo "正在重启电脑..."
sudo shutdown -r now
