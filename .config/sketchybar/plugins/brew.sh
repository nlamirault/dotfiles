#!/bin/sh

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

COUNT=$(brew outdated | wc -l | tr -d ' ')

COLOR=${RED}

case "$COUNT" in
  [3-5][0-9])
    COLOR=${ORANGE}
    ;;
  [1-2][0-9])
    COLOR=${YELLOW}
    ;;
  [1-9])
    COLOR=${WHITE}
    ;;
  0)
    COLOR=${GREEN}
    COUNT=􀆅
    ;;
esac

sketchybar --set "${NAME}" label="${COUNT}" icon.color="${COLOR}"
