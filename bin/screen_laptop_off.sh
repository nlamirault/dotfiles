#!/bin/bash

# Copyright (C) 2016-2017 Nicolas Lamirault <nicolas.lamirault@gmail.com>

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
# Désactiver l'écran du laptop.
#

xrandr --output VGA-0 --mode 1920x1080 --pos 1x0 --rotate normal --output LVDS-0 --off --output HDMI-0 --off --output DP-3 --off --output DP-2 --off --output DP-1 --off --output DP-0 --off

xrandr --output VGA-0 --mode 1920x1080 --pos 1680x0 --rotate normal --output LVDS-0 --off --output HDMI-0 --off --output DP-3 --off --output DP-2 --off --output DP-1 --mode 1680x1050 --pos 0x0 --rotate normal --output DP-0 --off
