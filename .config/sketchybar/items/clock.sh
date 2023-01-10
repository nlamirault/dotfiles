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
    --add item clock right                                           \
    --set clock                                                      \
          icon.padding_right="${DATA_ICON_PADDING_RIGHT}"            \
          icon.padding_left="${DATA_ICON_PADDING_LEFT}"              \
          icon.color="${BAR_YELLOW}"                                 \
          label.width=48                                             \
          label.color="${BAR_YELLOW}"                                \
          label.padding_right="${DATA_LABEL_PADDING_RIGHT}"          \
          background.padding_left="${DATA_BACKGROUND_PADDING_LEFT}"  \
          script="${SKETCHYBAR_PLUGIN_DIR}/clock.sh"                 \
          update_freq=1
