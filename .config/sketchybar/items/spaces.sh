#!/bin/env bash

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

CLICK_SCRIPT='yabai -m space --create sketchybar --trigger space_change'

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
# spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar \
    --add space "space.${sid}" left                                \
    --set "space.${sid}" associated_space="${sid}"                 \
                     icon="${SPACE_ICONS[i]}"                  \
                     icon.padding_left=10                      \
                     icon.padding_right=15                      \
                     padding_left=2                             \
                     padding_right=2                            \
                     label.padding_right=20                     \
                     icon.highlight_color=$RED                  \
                     label.font="${FONT}:Regular:16.0"          \
                     label.background.height=26                 \
                     label.background.drawing=on                \
                     label.background.color="${BACKGROUND_2}"   \
                     label.background.corner_radius=8           \
                     label.drawing=off                          \
                     script="${SKETCHYBAR_PLUGIN_DIR}/space.sh" \
    --subscribe "space.${sid}" mouse.clicked
done

sketchybar \
  --add bracket spaces '/space\..*/'                      \
  --set spaces background.color="${BACKGROUND_1}"        \
               background.border_color="${BACKGROUND_2}" \
               background.border_width=2                 \
               background.drawing=on


sketchybar \
  --add item separator left                        \
  --set separator icon=                           \
                  icon.font="${FONT}:Regular:16.0" \
                  padding_left=17                  \
                  padding_right=10                 \
                  label.drawing=off                \
                  associated_display=active        \
                  click_script="${CLICK_SCRIPT}"   \
                  icon.color="${WHITE}"
