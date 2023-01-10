#!/usr/bin/env sh

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
    --add item network right                             \
    --set network label.font="${FONT}:Semibold:12.0"     \
            label.padding_right=4                        \
            label.color="${MAGENTA}"                     \
            icon.color="${MAGENTA}"                      \
            icon.font="${FONT}:Medium:18.0"              \
            label.padding_right=4                        \
            update_freq=1                                \
            script="${SKETCHYBAR_PLUGIN_DIR}/network.sh"
