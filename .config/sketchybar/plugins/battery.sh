#!/bin/bash

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

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "${PERCENTAGE}" = "" ]; then
  exit 0
fi

DRAWING=on
COLOR=${WHITE}

case ${PERCENTAGE} in
  9[0-9]|100)
    ICON=${BATTERY_100};
    DRAWING=off
    ;;
  [6-8][0-9])
    ICON=${BATTERY_75};
    DRAWING=off
    ;;
  [3-5][0-9])
    ICON=${BATTERY_50}
    ;;
  [1-2][0-9])
    ICON=${BATTERY_25};
    COLOR=${ORANGE}
    ;;
  *)
    ICON=${BATTERY_0};
    COLOR=${RED}
    ;;
esac

if [[ "${CHARGING}" != "" ]]; then
  ICON=${BATTERY_CHARGING}
  DRAWING=off
fi

sketchybar --set "${NAME}" drawing="${DRAWING}" icon="${ICON}" icon.color="${COLOR}"
