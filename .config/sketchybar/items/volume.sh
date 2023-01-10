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

sketchybar \
    --add slider volume right                                \
    --set volume script="${SKETCHYBAR_PLUGIN_DIR}/volume.sh" \
                 updates=on                                   \
                 icon.drawing=off                             \
                 label.drawing=off                            \
                 padding_left=0                               \
                 padding_right=0                              \
                 slider.highlight_color="${BLUE}"             \
                 slider.background.height=5                   \
                 slider.background.corner_radius=3            \
                 slider.background.color="${BACKGROUND_2}"    \
                 slider.knob=􀀁                                \
    --subscribe volume volume_change mouse.clicked

sketchybar \
    --add alias "Control Center,Sound" right                                   \
    --rename "Control Center,Sound" volume_alias                               \
    --set volume_alias icon.drawing=off                                        \
                       label.drawing=off                                       \
                       alias.color="${WHITE}"                                  \
                       padding_right=0                                         \
                       padding_left=-5                                         \
                       width=50                                                \
                       align=right                                             \
                       click_script="${SKETCHYBAR_PLUGIN_DIR}/volume_click.sh"

sketchybar \
    --add bracket status volume volume_alias               \
    --set status background.color="${BACKGROUND_1}"        \
                 background.border_color="${BACKGROUND_2}" \
                 background.border_width=2
