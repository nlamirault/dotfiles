#!/usr/bin/env bash

set -euo pipefail

SESSION="${1:-nlamirault}"
PROJECTS="$HOME/Projects"
DIVONA="$HOME/Projects/Divona"
PORTEFAIX="$HOME/Projects/Portefaix"
PILOTARIAK="$HOME/Projects/Pilotariak"

# Inside a herdr pane these point the CLI at the current session instead of $SESSION.
unset HERDR_ENV HERDR_SOCKET_PATH HERDR_WORKSPACE_ID HERDR_TAB_ID HERDR_PANE_ID

hd() { herdr --session "$SESSION" "$@"; }

if ! hd workspace list >/dev/null 2>&1; then
  nohup herdr --session "$SESSION" server >/dev/null 2>&1 &
  for _ in $(seq 1 50); do
    hd workspace list >/dev/null 2>&1 && break
    sleep 0.1
  done
  hd workspace list >/dev/null 2>&1 || { echo "herdr session $SESSION did not start" >&2; exit 1; }
fi

labels=$(hd workspace list | jq -r '.result.workspaces[].label')

add_workspace() {
  local label=$1 dir=$2
  grep -qxF "$label" <<<"$labels" && return
  hd workspace create --cwd "$dir" --label "$label" --no-focus >/dev/null
  echo "created workspace $label ($dir)"
}

add_workspace Projects "$PROJECTS"
add_workspace divona-agent "$DIVONA/divona-agent"
add_workspace dotfiles "$PROJECTS/dotfiles"
add_workspace agentic "$PROJECTS/agentic"
add_workspace kortex "$PROJECTS/kortex"
add_workspace schema-hub "$PROJECTS/schema-hub"
add_workspace otel-lab "$PROJECTS/opentelemetry-lab"

add_workspace portefaix-infra "$PORTEFAIX/portefaix-infrastructure"
add_workspace portefaix-k8s "$PORTEFAIX/portefaix-kubernetes"

add_workspace frontis "$PILOTARIAK/frontis"
add_workspace kancha "$PILOTARIAK/kancha"

work_id=$(hd workspace list | jq -r '.result.workspaces[] | select(.label == "Projects") | .workspace_id')
hd workspace focus "$work_id" >/dev/null

if [ -t 1 ]; then
  exec herdr session attach "$SESSION"
fi
