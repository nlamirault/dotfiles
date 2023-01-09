#!/usr/bin/env sh

. "${HOME}/.config/sketchybar/env.sh"

sketchybar \
    --add item network right                             \
    --set network label.font="${FONT}:Semibold:12.0"     \
            label.padding_right=4                        \
            label.color="${MAGENTA}"                     \
            icon.color="${MAGENTA}"                      \
            icon.font="${FONT}:Medium:18.0"              \
            label.padding_right=4                        \
            update_freq=1                                \
            script="${SKETCHYBAR_PLUGIN_DIR}/network.sh"