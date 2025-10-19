#!/bin/bash

# ────────────────────────────────────
# ▸ Toggle: Display Playback Controls
# ────────────────────────────────────
MUSIC_DISPLAY_CONTROLS=true

DISABLED_COLOR=$OVERLAY0

POPUP_SCRIPT="sketchybar -m --set music.anchor popup.drawing=toggle"

# Dynamic values based on toggle
POPUP_HEIGHT=$([ "$MUSIC_DISPLAY_CONTROLS" = false ] && echo 85 || echo 120)
IMAGE_SCALE=$([ "$MUSIC_DISPLAY_CONTROLS" = false ] && echo 0.10 || echo 0.15)
Y_OFFSET=$([ "$MUSIC_DISPLAY_CONTROLS" = false ] && echo -25 || echo -5)

# ────────────────────────────────────
# ▸ Items
# ────────────────────────────────────

music_anchor=(
  script="$PLUGIN_DIR/music/music.sh $MUSIC_DISPLAY_CONTROLS"
  click_script="$POPUP_SCRIPT"
  popup.horizontal=on
  popup.align=center
  popup.height=$POPUP_HEIGHT
  icon=􁁒
  icon.font="SF Pro:Bold:20.0"
  icon.y_offset=2
  label.drawing=on
  label.font="$FONT:Bold:14.0"
  label.padding_left=8
  label.y_offset=0
  label.color=$GREEN
  icon.color=$GREEN
  drawing=on
  update_freq=5
  updates=on
)

music_cover=(
  script="$PLUGIN_DIR/music/music.sh $MUSIC_DISPLAY_CONTROLS"
  click_script="open -a 'Music'; $POPUP_SCRIPT"
  label.drawing=off
  icon.drawing=off
  padding_left=12
  padding_right=10
  background.image.scale=$IMAGE_SCALE
  background.image.drawing=on
  background.drawing=on
)

music_title=(
  icon.drawing=off
  padding_left=0
  padding_right=0
  width=0
  label.font="$FONT:Bold:15.0"
  label.color=$TEXT
  y_offset=$((50 + Y_OFFSET))
)

music_artist=(
  icon.drawing=off
  y_offset=$((30 + Y_OFFSET))
  padding_left=0
  padding_right=0
  width=0
  label.font="$FONT:Regular:13.0"
  label.color=$SUBTEXT0
)

music_album=(
  icon.drawing=off
  padding_left=0
  padding_right=0
  y_offset=$((15 + Y_OFFSET))
  width=0
  label.font="$FONT:Regular:13.0"
  label.color=$SUBTEXT1
)

ICON_WIDTH=50
LABEL_WIDTH=50
SLIDER_WIDTH=100

STATE_WIDTH=$([ "$MUSIC_DISPLAY_CONTROLS" = true ] && echo 0 || echo $((ICON_WIDTH + LABEL_WIDTH + SLIDER_WIDTH)))

music_state=(
  icon.drawing=on
  icon.font="$FONT:10.0"
  icon.width=$ICON_WIDTH
  icon="00:00"
  label.drawing=on
  label.font="$FONT:10.0"
  label.width=$LABEL_WIDTH
  label="00:00"
  label.padding_left=10
  y_offset=$((Y_OFFSET))
  width=$STATE_WIDTH
  slider.background.height=6
  slider.background.corner_radius=3
  slider.background.color=$SURFACE0
  slider.highlight_color=$GREEN
  slider.percentage=0
  slider.width=$SLIDER_WIDTH
  script="$PLUGIN_DIR/music/music.sh $MUSIC_DISPLAY_CONTROLS"
  update_freq=1
  updates=when_shown
)

# ────────────────────────────────────
# ▸ Optional Controls
# ────────────────────────────────────

CONTROLS_Y_OFFSET=$((-30 + Y_OFFSET))

music_shuffle=(
  icon=􀊝
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$DISABLED_COLOR
  icon.highlight_color=$GREEN
  label.drawing=off
  script="$PLUGIN_DIR/music/music.sh $MUSIC_DISPLAY_CONTROLS"
  y_offset=$CONTROLS_Y_OFFSET
)

music_back=(
  icon=􀊎
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$BASE
  script="$PLUGIN_DIR/music/music.sh $MUSIC_DISPLAY_CONTROLS"
  label.drawing=off
  y_offset=$CONTROLS_Y_OFFSET
)

music_play=(
  icon=􀊄
  background.height=40
  background.corner_radius=20
  width=40
  align=center
  background.color=$BASE
  background.border_color=$SURFACE0
  background.border_width=1
  background.drawing=on
  icon.padding_left=4
  icon.padding_right=4
  icon.color=$GREEN
  updates=on
  label.drawing=off
  script="$PLUGIN_DIR/music/music.sh $MUSIC_DISPLAY_CONTROLS"
  y_offset=$CONTROLS_Y_OFFSET
)

music_next=(
  icon=􀊐
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$BASE
  label.drawing=off
  script="$PLUGIN_DIR/music/music.sh $MUSIC_DISPLAY_CONTROLS"
  y_offset=$CONTROLS_Y_OFFSET
)

music_repeat=(
  icon=􀊞
  icon.highlight_color=$GREEN
  icon.padding_left=5
  icon.padding_right=10
  icon.color=$DISABLED_COLOR
  label.drawing=off
  script="$PLUGIN_DIR/music/music.sh $MUSIC_DISPLAY_CONTROLS"
  y_offset=$CONTROLS_Y_OFFSET
)

music_controls=(
  background.color=$GREEN
  background.corner_radius=11
  background.drawing=on
  y_offset=$CONTROLS_Y_OFFSET
)

# ────────────────────────────────────
# ▸ SketchyBar Setup
# ────────────────────────────────────

sketchybar --add item music.anchor left                      \
           --set music.anchor "${music_anchor[@]}"           \
           --subscribe music.anchor  mouse.exited.global         \
                                     music_change media_change \
                                                                 \
           --add item music.cover popup.music.anchor         \
           --set music.cover "${music_cover[@]}"             \
                                                                 \
           --add item music.title popup.music.anchor         \
           --set music.title "${music_title[@]}"             \
                                                                 \
           --add item music.artist popup.music.anchor        \
           --set music.artist "${music_artist[@]}"           \
                                                                 \
           --add item music.album popup.music.anchor         \
           --set music.album "${music_album[@]}"             \
                                                                 \
           --add slider music.state popup.music.anchor       \
           --set music.state "${music_state[@]}"             \

# ────────────────────────────────────
# ▸ Conditionally Add Controls
# ────────────────────────────────────

if [ "$MUSIC_DISPLAY_CONTROLS" = true ]; then
  sketchybar --add item music.shuffle popup.music.anchor       \
             --set music.shuffle "${music_shuffle[@]}"         \
             --subscribe music.shuffle mouse.clicked             \
                                                                   \
             --add item music.back popup.music.anchor          \
             --set music.back "${music_back[@]}"               \
             --subscribe music.back mouse.clicked                \
                                                                   \
             --add item music.play popup.music.anchor          \
             --set music.play "${music_play[@]}"               \
             --subscribe music.play mouse.clicked                \
                                                                   \
             --add item music.next popup.music.anchor          \
             --set music.next "${music_next[@]}"               \
             --subscribe music.next mouse.clicked                \
                                                                   \
             --add item music.repeat popup.music.anchor        \
             --set music.repeat "${music_repeat[@]}"           \
             --subscribe music.repeat mouse.clicked              \
                                                                   \
             --add item music.spacer popup.music.anchor        \
             --set music.spacer width=5                          \
                                                                   \
             --add bracket music.controls music.shuffle        \
                                            music.back           \
                                            music.play           \
                                            music.next           \
                                            music.repeat         \
             --set music.controls "${music_controls[@]}"
fi

# ────────────────────────────────────
# ▸ Trigger Initial Update
# ────────────────────────────────────

sketchybar --trigger music_change media_change
