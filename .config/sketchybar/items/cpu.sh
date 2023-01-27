#!/usr/bin/env sh

sketchybar --add item cpu right                  \
           --set cpu label.font="$FONT:Heavy:12" \
                     label.color="$WHITE"        \
                     icon="$CPU"                 \
                     icon.color="$BLUE"         \
                     icon.font="$FONT:Bold:17.0" \
                     update_freq=60              \
                     script="$PLUGIN_DIR/cpu.sh"