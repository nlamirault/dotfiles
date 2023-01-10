#!/bin/env sh

# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

. "${HOME}/.config/sketchybar/env.sh"

update() {
    source "$HOME/.config/sketchybar/colors.sh"
    source "$HOME/.config/sketchybar/icons.sh"

    WINDOW=$(yabai -m query --windows --window)
    CURRENT=$(echo "$WINDOW" | jq '.["stack-index"]')

    args=()
    if [[ $CURRENT -gt 0 ]]; then
        LAST=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
        args+=(--set $NAME icon=$YABAI_STACK icon.color=$GREEN label.drawing=on label=$(printf "[%s/%s]" "$CURRENT" "$LAST"))
        yabai -m config active_window_border_color $GREEN > /dev/null 2>&1 &

    else
        args+=(--set $NAME label.drawing=off)
        case "$(echo "$WINDOW" | jq '.["is-floating"]')" in
            "false")
                if [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
                    args+=(--set $NAME icon=$YABAI_FULLSCREEN_ZOOM icon.color=$YELLOW)
                    yabai -m config active_window_border_color $YELLOW > /dev/null 2>&1 &
                elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
                    args+=(--set $NAME icon=$YABAI_PARENT_ZOOM icon.color=$BLUE)
                    yabai -m config active_window_border_color $BLUE > /dev/null 2>&1 &
                else
                    args+=(--set $NAME icon=$YABAI_GRID icon.color=$WHITE)
                    yabai -m config active_window_border_color $WHITE > /dev/null 2>&1 &
                fi
                ;;
            "true")
                args+=(--set $NAME icon=$YABAI_FLOAT icon.color=$MAGENTA)
                yabai -m config active_window_border_color $MAGENTA > /dev/null 2>&1 &
                ;;
        esac
    fi

    sketchybar -m "${args[@]}"
}

mouse_clicked() {
    yabai -m window --toggle float
    update
}

case "$SENDER" in
    "mouse.clicked") mouse_clicked
    ;;
    "forced") exit 0
    ;;
    *) update
    ;;
esac




# window_state() {
#   source "$HOME/.config/sketchybar/colors.sh"
#   source "$HOME/.config/sketchybar/icons.sh"

#   WINDOW=$(yabai -m query --windows --window)
#   CURRENT=$(echo "$WINDOW" | jq '.["stack-index"]')

#   args=()
#   if [[ $CURRENT -gt 0 ]]; then
#     LAST=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
#     args+=(--set $NAME icon=$YABAI_STACK icon.color=$RED label.drawing=on label=$(printf "[%s/%s]" "$CURRENT" "$LAST"))
#     yabai -m config active_window_border_color $RED > /dev/null 2>&1 &

#   else
#     args+=(--set $NAME label.drawing=off)
#     case "$(echo "$WINDOW" | jq '.["is-floating"]')" in
#       "false")
#         if [ "$(echo "$WINDOW" | jq '.["has-fullscreen-zoom"]')" = "true" ]; then
#           args+=(--set $NAME icon=$YABAI_FULLSCREEN_ZOOM icon.color=$GREEN)
#           yabai -m config active_window_border_color $GREEN > /dev/null 2>&1 &
#         elif [ "$(echo "$WINDOW" | jq '.["has-parent-zoom"]')" = "true" ]; then
#           args+=(--set $NAME icon=$YABAI_PARENT_ZOOM icon.color=$BLUE)
#           yabai -m config active_window_border_color $BLUE > /dev/null 2>&1 &
#         else
#           args+=(--set $NAME icon=$YABAI_GRID icon.color=$ORANGE)
#           yabai -m config active_window_border_color $WHITE > /dev/null 2>&1 &
#         fi
#         ;;
#       "true")
#         args+=(--set $NAME icon=$YABAI_FLOAT icon.color=$MAGENTA)
#         yabai -m config active_window_border_color $MAGENTA > /dev/null 2>&1 &
#         ;;
#     esac
#   fi

#   sketchybar -m "${args[@]}"
# }

# windows_on_spaces () {
#   CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

#   args=()
#   while read -r line
#   do
#     for space in $line
#     do
#       icon_strip=" "
#       apps=$(yabai -m query --windows --space $space | jq -r ".[].app")
#       if [ "$apps" != "" ]; then
#         while IFS= read -r app; do
#           icon_strip+=" $($HOME/.config/sketchybar/plugins/icon_map.sh "$app")"
#         done <<< "$apps"
#       fi
#       args+=(--set space.$space label="$icon_strip" label.drawing=on)
#     done
#   done <<< "$CURRENT_SPACES"

#   sketchybar -m "${args[@]}"
# }

# mouse_clicked() {
#   yabai -m window --toggle float
#   window_state
# }

# case "$SENDER" in
#   "mouse.clicked") mouse_clicked
#   ;;
#   "forced") exit 0
#   ;;
#   "window_focus") window_state
#   ;;
#   "windows_on_spaces") windows_on_spaces
#   ;;
# esac
