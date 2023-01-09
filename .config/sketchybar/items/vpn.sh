#!/bin/env sh

. "${HOME}/.config/sketchybar/env.sh"

sketchybar \
    -m --add item vpn left \
    --set vpn icon= update_freq=5 script="${SKETCHYBAR_PLUGIN_DIR}/vpn.sh"