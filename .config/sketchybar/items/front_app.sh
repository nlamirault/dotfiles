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

FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO"'

sketchybar \
    --add event window_focus                                      \
    --add event windows_on_spaces                                 \
    --add item system.yabai left                                  \
    --set system.yabai script="${SKETCHYBAR_PLUGIN_DIR}/yabai.sh" \
          icon.font="${FONT}:Bold:16.0"                           \
          label.drawing=off                                       \
          icon.width=30                                           \
          icon="${YABAI_GRID}"                                    \
          icon.color="${ORANGE}"                                  \
          associated_display=active                               \
    --subscribe system.yabai                                      \
                window_focus                                      \
                windows_on_spaces                                 \
                mouse.clicked                                     \
    --add item front_app left                                     \
    --set front_app script="${FRONT_APP_SCRIPT}"                  \
          icon.drawing=off                                        \
          padding_left=0                                          \
          label.color="${WHITE}"                                  \
          label.font="${FONT}:Black:12.0"                         \
          associated_display=active                               \
    --subscribe front_app front_app_switched
