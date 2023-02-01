#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

sketchybar --add item      ipaddress right                 \
           --set ipaddress label.font="$FONT:Heavy:12"  \
                           label.color="$WHITE"          \
                           icon="$MEMORY"               \
                           icon.font="$FONT:Bold:16.0"  \
                           icon.color="$BLUE"          \
                           update_freq=15               \
                           script="$PLUGIN_DIR/memory.sh"