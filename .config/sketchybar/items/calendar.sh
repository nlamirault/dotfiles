#!/bin/env sh

. "${HOME}/.config/sketchybar/env.sh"

sketchybar \
    --add item     calendar right                                 \
    --set calendar icon=cal                                       \
                   icon.font="$FONT:Black:12.0"                   \
                   icon.padding_right=0                           \
                   label.width=45                                 \
                   label.align=right                              \
                   padding_left=15                                \
                   update_freq=30                                 \
                   script="${SKETCHYBAR_PLUGIN_DIR}/calendar.sh"  \
                   click_script="${SKETCHYBAR_PLUGIN_DIR}/zen.sh" \
    --subscribe    calendar system_woke
