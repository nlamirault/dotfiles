#!/bin/zsh

function ai-vibe() {
  ln -s "${HOME}/Projects/vibe-coding/.rules" .rules
  ln -s "${HOME}/Projects/vibe-coding/AGENTS.md" AGENTS.md
  ln -s "${HOME}/Projects/vibe-coding/AGENTS.md" CLAUDE.md
  mkdir -p .kiro/steering/
  # ln -s "${HOME}/Projects/vibe-coding/AGENTS.md" .kiro/steering
}

function ai-claude() {
  local env_vars=(
    "DISABLE_ERROR_REPORTING=1"
    "DISABLE_TELEMETRY=1"
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true"
  )

  local claude_args=("--dangerously-skip-permissions")
  claude_args+=("$@")
  env "${env_vars[@]}" "claude" "${claude_args[@]}"
}

function ai-claude-otel() {
  log_info "[Claude] Setting up Open Telemetry environment"
  export OTEL_LOGS_EXPORTER=otlp
  export OTEL_METRICS_EXPORTER=otlp
  export OTEL_TRACES_EXPORTER=otlp
  # export OTEL_EXPORTER_OTLP_PROTOCOL=http/json
  export OTEL_EXPORTER_OTLP_LOGS_PROTOCOL=http/json
  export OTEL_EXPORTER_OTLP_METRICS_PROTOCOL=http/json
  export OTEL_EXPORTER_OTLP_TRACES_PROTOCOL=http/json
  # export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
  # export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4318
  export OTEL_LOG_USER_PROMPTS=1
  # For debugging: reduce export intervals
  export OTEL_METRIC_EXPORT_INTERVAL=10000 # 10 seconds (default: 60000ms)
  export OTEL_LOGS_EXPORT_INTERVAL=5000    # 5 seconds (default: 5000ms)

  # Langsmith Open Telemetry endpoint
  log_info "[Claude] Setting up Langsmith"
  export OTEL_EXPORTER_OTLP_LOGS_ENDPOINT=https://api.smith.langchain.com/otel/v1/claude_code
  export OTEL_EXPORTER_OTLP_HEADERS="x-api-key=${langsmith_api_key},Langsmith-Project=${langsmith_project}"
  log_final "Running Claude with Open Telemetry ${OTEL_EXPORTER_OTLP_LOGS_ENDPOINT}"

  local env_vars=(
    "DISABLE_ERROR_REPORTING=1"
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true"
  )

  local claude_args=("--dangerously-skip-permissions")
  claude_args+=("$@")
  env "${env_vars[@]}" "claude" "${claude_args[@]}"
}

ai-git-diff() {
  local provider="${1:-claude}"
  local prompt="Summarize the changes in this git diff output."

  if [ "$provider" = "gemini" ]; then
    git diff | gemini -p "$prompt"
  elif [ "$provider" = "claude" ]; then
    git diff | ai-claude -p "$prompt"
  else
    echo "Unsupported provider: $provider. Please use 'gemini' or 'claude'."
    return 1
  fi
}
