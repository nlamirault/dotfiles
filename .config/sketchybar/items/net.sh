#!/usr/bin/env sh

sketchybar --add item net right	                        \
           --set net script="$PLUGIN_DIR/net.sh"        \
                     update_freq=1                      \
                     label.color=$WHITE                 \
                     label.padding_right=10 \
                     icon.padding_right=5
