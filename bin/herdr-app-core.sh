#!/usr/bin/env bash
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

# Open a second Herdr window, apart from herdr-start's, and make sure the
# project spaces exist. Safe to re-run: spaces live in herdr-core, so existing
# ones (matched by name and folder) are left alone.
set -euo pipefail

SESSION="${1:-nlamirault}"
PROJECTS="$HOME/Projects"
DIVONA="$PROJECTS/Divona"
PORTEFAIX="$PROJECTS/Portefaix"
PILOTARIAK="$PROJECTS/Pilotariak"

# name|folder — the first one is selected at the end.
SPACES=(
  "Projects|$PROJECTS"
  "divona-agent|$DIVONA/divona-agent"
  "dotfiles|$PROJECTS/dotfiles"
  "agentic|$PROJECTS/agentic"
  "kortex|$PROJECTS/kortex"
  "schema-hub|$PROJECTS/schema-hub"
  "otel-lab|$PROJECTS/opentelemetry-lab"
  "portefaix-infra|$PORTEFAIX/portefaix-infrastructure"
  "portefaix-k8s|$PORTEFAIX/portefaix-kubernetes"
  "frontis|$PILOTARIAK/frontis"
  "kancha|$PILOTARIAK/kancha"
)

# Spaces live in the core, and herdr-app finds its window through the app home,
# so a separate window needs both: its own core session and its own home. Set
# them outright — a shell inside the other window inherits that one's values.
# The socket is pinned to the state path, as in herdr-start: with
# XDG_RUNTIME_DIR set (xdg.shrc), hc would otherwise look under /var/folders.
export HC_SESSION="$SESSION"
export HC_SOCKET="${XDG_STATE_HOME:-$HOME/.local/state}/herdr-core/$SESSION/$SESSION.sock"
export HERDR_APP_HOME="$HOME/.config/herdr-app-$SESSION"

# A new home starts from the app defaults; bring the person's settings over once.
mkdir -p "$HERDR_APP_HOME"
for f in settings.json keys.json; do
  if [[ ! -e "$HERDR_APP_HOME/$f" && -e "$HOME/.config/herdr-app/$f" ]]; then
    cp "$HOME/.config/herdr-app/$f" "$HERDR_APP_HOME/$f"
  fi
done

# hc starts the core when it isn't running. Do it here, so a core of this
# session listening at another socket fails now, not as a 30s wait.
if ! out=$(hc server status 2>&1); then
  echo "herdr-app-core: $out" >&2
  exit 1
fi

# open -b would only raise whichever Herdr is already running. -n starts
# another instance, with this window's env.
if ! herdr-app ls >/dev/null 2>&1; then
  open -n -b dev.herdr.app \
    --env "HC_SESSION=$HC_SESSION" \
    --env "HC_SOCKET=$HC_SOCKET" \
    --env "HERDR_APP_HOME=$HERDR_APP_HOME"
fi

# herdr-app ls needs the window up. An empty list may only mean the core
# layout is still loading, so wait for spaces (or 30s, for a truly empty one)
# before comparing names — otherwise existing spaces get duplicated.
listing=""
for _ in $(seq 1 60); do
  listing=$(herdr-app ls 2>/dev/null) || listing=""
  if [[ -n "$listing" && "$(jq '.spaces | length' <<<"$listing")" -gt 0 ]]; then
    break
  fi
  sleep 0.5
done
if [[ -z "$listing" ]]; then
  echo "herdr-app-core: Herdr window not ready after 30s" >&2
  exit 1
fi

# A nameless space's name is derived from where its first terminal is, so
# match the folder too.
space_id() {
  herdr-app ls | jq -r --arg n "$1" --arg f "$2" '[.spaces[] | select(.machine == null and .name == $n and .folder == $f)][0].id // empty'
}

for entry in "${SPACES[@]}"; do
  name="${entry%%|*}"
  folder="${entry#*|}"

  id=$(space_id "$name" "$folder")
  if [[ -n "$id" ]]; then
    echo "ok      $name"
    continue
  fi
  if [[ ! -d "$folder" ]]; then
    echo "herdr-app-core: $name: folder $folder does not exist" >&2
    failed=1
    continue
  fi

  # Structural commands fail while the core layout is unavailable. A failed
  # attempt may still have made the space, so look again before each retry.
  for attempt in $(seq 1 10); do
    id=$(space_id "$name" "$folder")
    if [[ -n "$id" ]]; then
      echo "created $name ($folder)"
      break
    fi
    if out=$(herdr-app "do" space.new --name "$name" --folder "$folder" --focus false 2>&1); then
      echo "created $name ($folder)"
      break
    fi
    if [[ "$attempt" -eq 10 ]]; then
      echo "herdr-app-core: $name: $out" >&2
      failed=1
      break
    fi
    sleep 1
  done
done

first_name="${SPACES[0]%%|*}"
first_folder="${SPACES[0]#*|}"
id=$(space_id "$first_name" "$first_folder")
if [[ -n "$id" ]]; then
  herdr-app "do" space.select --id "$id" >/dev/null
else
  echo "herdr-app-core: $first_name: space not found, nothing selected" >&2
fi
exit "${failed:-0}"
