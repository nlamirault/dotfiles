#!/usr/bin/env sh

sketchybar --add item     calendar right                    \
           --set calendar icon="$CALENDAR"                  \
                          icon.font="$FONT:Bold:12.0"      \
                          icon.padding_right=0              \
                          label.align=right                 \
                          background.padding_left=2        \
                          update_freq=30                    \
                          script="$PLUGIN_DIR/calendar.sh"
                        #   click_script="$PLUGIN_DIR/zen.sh"
