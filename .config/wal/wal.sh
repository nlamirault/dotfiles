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

#
# Theme used:
# - sexy-belge
# - base16-materialer
# - base16-irblack
# - base16-google
#

source "${HOME}/.cache/wal/colors.sh"

# mkdir -p  "${HOME}/.config/termite"
# ln -sf "${HOME}/.cache/wal/termite" "${HOME}/.config/termite/config"
mkdir -p  "${HOME}/.config/dunst"
ln -sf "${HOME}/.cache/wal/dunstrc" "${HOME}/.config/dunst/dunstrc"

pkill dunst
dunst &
