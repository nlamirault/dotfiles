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
    --add item        cpu.top right                     \
    --set cpu.top     label.font="${FONT}:Semibold:7"   \
                      label=CPU                         \
                      icon.drawing=off                  \
                      width=0                           \
                      padding_right=15                  \
                      y_offset=6                        \
    --add item        cpu.percent right                 \
    --set cpu.percent label.font="${FONT}:Heavy:12"     \
                      label=CPU                         \
                      y_offset=-4                       \
                      padding_right=15                  \
                      width=55                          \
                      icon.drawing=off                  \
                      update_freq=2                     \
                      mach_helper="${HELPER}"           \
    --add graph       cpu.sys right 75                  \
    --set cpu.sys     width=0                           \
                      graph.color="${RED}"              \
                      graph.fill_color="${RED}"         \
                      label.drawing=off                 \
                      icon.drawing=off                  \
                      background.height=30              \
                      background.drawing=on             \
                      background.color="${TRANSPARENT}" \
    --add graph       cpu.user right 75                 \
    --set cpu.user    graph.color="${BLUE}"             \
                      label.drawing=off                 \
                      icon.drawing=off                  \
                      background.height=30              \
                      background.drawing=on             \
                      background.color="${TRANSPARENT}"
