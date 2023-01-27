#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

sketchybar --add item      public_ip right                 \
           --set public_ip label.font="$FONT:Heavy:12"  \
                           label.color="$WHITE"          \
                           icon="$NETWORK"               \
                           icon.font="$FONT:Bold:15.0"  \
                           icon.color="$MAGENTA"          \
                           update_freq=15               \
                           script="$PLUGIN_DIR/ipaddress.sh" \
           --add item       private_ip right                 \
           --set private_ip label.font="$FONT:Heavy:12"  \
                            label.color="$WHITE"          \
                            icon="$NETWORK"               \
                            icon.font="$FONT:Bold:15.0"  \
                            icon.color="$MAGENTA"          \