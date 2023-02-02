#!/usr/bin/env sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)
SPACE_CLICK_SCRIPT='[ "$BUTTON" = "right" ] && (yabai -m space --destroy $SID; sketchybar --trigger space_change) || yabai -m space --focus $SID 2>/dev/null'

sid=0
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space      space.$sid left                               \
             --set space.$sid associated_space=$sid                         \
                              icon=${SPACE_ICONS[i]}                        \
                              icon.padding_left=0                           \
                              icon.padding_right=0                          \
                              label.padding_right=1                         \
                              icon.color=$GREY                              \
                              icon.highlight_color=$WHITE                   \
                              background.drawing=on                         \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.background.drawing=on                   \
                              label.background.corner_radius=9              \
                              label.drawing=off                             \
                              associated_display=active                     \
                              script="$PLUGIN_DIR/space.sh"                 \
                              click_script="$SPACE_CLICK_SCRIPT"
done

sketchybar   --add item       separator left                                  \
             --set separator  icon=                                          \
                              icon.font="Hack Nerd Font:Regular:16.0"         \
                              background.padding_left=1                       \
                              background.padding_right=1                      \
                              label.drawing=off                               \
                              associated_display=active                       \
                              click_script='yabai -m space --create sketchybar --trigger space_change' \
                              icon.color=$WHITE