#!/usr/bin/env sh

# Copyright (C) 2016-2019 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
export WIFI_INTERFACE="wlp3s0"
export ETH_INTERFACE="enp0s25"

# Launch bar1 and bar2

MONITOR=eDP-1 polybar top &
MONITOR=DP-2-1 polybar top &
MONITOR=DP-2-3 polybar top &
MONITOR=DP-2 polybar top &
MONITOR=eDP-1 polybar bottom &
MONITOR=DP-2-1 polybar bottom &
MONITOR=DP-2-3 polybar bottom &
MONITOR=DP-2 polybar bottom &

# Launch polybar
# MONITOR=eDP-1 polybar main &
# MONITOR=DP-2-1 polybar main &
# MONITOR=DP-2-3 polybar main &

echo "Bars launched..."
