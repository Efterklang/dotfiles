# Add event
sketchybar -m --add event song_update com.apple.iTunes.playerInfo

# Add Music Item
sketchybar -m --add item music right                         \
    --set music script="~/.config/sketchybar/scripts/music"  \
    click_script="~/.config/sketchybar/scripts/music_click"  \
    label.padding_right=10                                   \
    label.font="$FONT:semibold:13.0"                         \
    drawing=off                                              \
    update_freq=10                                           \
    --subscribe music song_update                            \
