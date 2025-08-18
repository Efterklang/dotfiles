#!/bin/bash

pkill Raycast
brew services restart borders
aerospace reload-config
osascript -e 'display notification "重载配置完成" with title "Reload Status"'
sleep 3
open -a Raycast
