desktop=$(system_profiler SPDisplaysDataType | grep -c 'Retina')
if [ "$desktop" -gt 0 ]; then
  sketchybar --add alias "Session,Item-0" right \
		   --set "Session,Item-0" click_script="$PLUGIN_DIR/session.sh"
else
  sketchybar --add alias "Session,Item-0" left \
		   --set "Session,Item-0" click_script="$PLUGIN_DIR/session.sh"
fi

